import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/exceptions.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/time_slot.dart';
import 'auth_provider.dart';
import 'home_providers.dart';
import 'repository_providers.dart';

const List<Map<String, dynamic>> dentalServices = [
  {'name': 'General Checkup', 'price': 500},
  {'name': 'Teeth Cleaning', 'price': 1500},
  {'name': 'Tooth Extraction', 'price': 2000},
  {'name': 'Filling (Composite)', 'price': 3000},
  {'name': 'Root Canal', 'price': 8000},
  {'name': 'Crown Placement', 'price': 12000},
  {'name': 'Teeth Whitening', 'price': 5000},
  {'name': 'Braces Consultation', 'price': 1000},
  {'name': 'X-Ray', 'price': 800},
  {'name': 'Scaling', 'price': 2500},
];

class BookingState {
  final List<Map<String, dynamic>> selectedServices;
  final ClinicModel? selectedClinic;
  final DateTime? selectedDate;
  final TimeSlot? selectedSlot;
  final String? paymentMethod;
  final String? note;
  final bool isLoading;
  final String? error;

  const BookingState({
    this.selectedServices = const [],
    this.selectedClinic,
    this.selectedDate,
    this.selectedSlot,
    this.paymentMethod,
    this.note,
    this.isLoading = false,
    this.error,
  });

  int get totalBill =>
      selectedServices.fold(0, (sum, service) => sum + (service['price'] as int));

  BookingState copyWith({
    List<Map<String, dynamic>>? selectedServices,
    ClinicModel? selectedClinic,
    DateTime? selectedDate,
    TimeSlot? selectedSlot,
    String? paymentMethod,
    String? note,
    bool? isLoading,
    String? error,
  }) {
    return BookingState(
      selectedServices: selectedServices ?? this.selectedServices,
      selectedClinic: selectedClinic ?? this.selectedClinic,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      note: note ?? this.note,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class BookingNotifier extends StateNotifier<BookingState> {
  final Ref _ref;
  BookingNotifier(this._ref) : super(const BookingState());

  void toggleService(Map<String, dynamic> service) {
    final exists = state.selectedServices.any((s) => s['name'] == service['name']);
    if (exists) {
      state = state.copyWith(
        selectedServices:
            state.selectedServices.where((s) => s['name'] != service['name']).toList(),
      );
    } else {
      state = state.copyWith(selectedServices: [...state.selectedServices, service]);
    }
  }

  Future<void> selectClinic(ClinicModel clinic) async {
    var selected = clinic;
    if (clinic.id.startsWith('osm_')) {
      selected = await _saveOsmClinic(clinic);
    }
    state = state.copyWith(selectedClinic: selected, error: null);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date, selectedSlot: null, error: null);
  }

  void selectSlot(TimeSlot slot) {
    state = state.copyWith(selectedSlot: slot, error: null);
  }

  void selectPaymentMethod(String method) {
    state = state.copyWith(paymentMethod: method, error: null);
  }

  void setNote(String note) {
    state = state.copyWith(note: note);
  }

  void reset() {
    state = const BookingState();
  }

  Future<bool> bookAppointment() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return false;

    if (state.selectedServices.isEmpty ||
        state.selectedClinic == null ||
        state.selectedDate == null ||
        state.selectedSlot == null ||
        state.paymentMethod == null) {
      state = state.copyWith(error: 'Please complete all booking steps.');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final repo = _ref.read(appointmentRepositoryProvider);
      final profile = await _ref.read(currentProfileProvider.future);
      final doctorId = await _findDoctorForClinic(state.selectedClinic!.id);
      final endTime = _endTimeForSlot(state.selectedSlot!.start);

      await repo.bookAppointment(
        patientId: user.id,
        doctorId: doctorId,
        clinicId: state.selectedClinic!.id,
        clinicName: state.selectedClinic!.name,
        serviceName: state.selectedServices.map((s) => s['name']).join(', '),
        patientName: profile?.fullName ?? user.email ?? 'Unknown',
        patientPhone: profile?.phone ?? '',
        appointmentDate: state.selectedDate!,
        startTime: state.selectedSlot!.start,
        endTime: endTime,
        amount: state.totalBill.toDouble(),
        paymentMethod: state.paymentMethod!,
        servicesSelected: state.selectedServices,
        notes: state.note,
      );

      _ref.invalidate(upcomingAppointmentsProvider);
      state = state.copyWith(isLoading: false);
      return true;
    } on AppException catch (e) {
      final msg = e.type == 'duplicate'
          ? 'This time slot is already booked. Please choose another.'
          : e.message;
      state = state.copyWith(isLoading: false, error: msg);
      return false;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred. Please try again.',
      );
      return false;
    }
  }

  Future<ClinicModel> _saveOsmClinic(ClinicModel clinic) async {
    final supabase = Supabase.instance.client;
    final existing = await supabase
        .from('clinics')
        .select('id')
        .eq('name', clinic.name)
        .eq('lat', clinic.lat)
        .eq('lng', clinic.lng)
        .limit(1)
        .maybeSingle();

    if (existing != null) {
      return clinic.copyWith(id: existing['id'] as String);
    }

    final inserted = await supabase
        .from('clinics')
        .insert({
          'name': clinic.name,
          'address': clinic.address,
          'lat': clinic.lat,
          'lng': clinic.lng,
        })
        .select('id')
        .single();

    return clinic.copyWith(id: inserted['id'] as String);
  }

  Future<String?> _findDoctorForClinic(String clinicId) async {
    final response = await Supabase.instance.client
        .from('doctors')
        .select('id')
        .eq('clinic_id', clinicId)
        .eq('status', 'approved')
        .limit(1)
        .maybeSingle();
    return response?['id'] as String?;
  }

  String _endTimeForSlot(String start) {
    final parts = start.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final end = DateTime(2026, 1, 1, hour, minute).add(const Duration(minutes: 30));
    return '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier(ref);
});

final availableSlotsProvider = FutureProvider.family<List<TimeSlot>, DateTime>((
  ref,
  date,
) async {
  final clinic = ref.watch(bookingProvider.select((s) => s.selectedClinic));
  if (clinic == null) return [];

  final repo = ref.read(appointmentRepositoryProvider);
  return repo.fetchAvailableSlots(clinicId: clinic.id, date: date);
});
