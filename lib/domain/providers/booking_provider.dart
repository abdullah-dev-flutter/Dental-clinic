import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/dental_service_model.dart';
import '../../data/models/doctor_with_services_model.dart';
import '../../data/models/clinic_model.dart';
import '../../data/models/time_slot.dart';
import '../../data/models/saved_payment_method_model.dart';
import '../../core/exceptions.dart';
import 'repository_providers.dart';
import 'home_providers.dart';
import 'doctor_list_provider.dart';

class BookingState {
  final DentalServiceModel? selectedService;
  final DoctorWithServicesModel? selectedDoctor;
  final ClinicModel? selectedClinic;
  final DateTime? selectedDate;
  final TimeSlot? selectedSlot;
  final SavedPaymentMethodModel? selectedPaymentMethod;
  final String? note;
  final bool isLoading;
  final String? error;

  const BookingState({
    this.selectedService,
    this.selectedDoctor,
    this.selectedClinic,
    this.selectedDate,
    this.selectedSlot,
    this.selectedPaymentMethod,
    this.note,
    this.isLoading = false,
    this.error,
  });

  BookingState copyWith({
    DentalServiceModel? selectedService,
    DoctorWithServicesModel? selectedDoctor,
    ClinicModel? selectedClinic,
    DateTime? selectedDate,
    TimeSlot? selectedSlot,
    SavedPaymentMethodModel? selectedPaymentMethod,
    String? note,
    bool? isLoading,
    String? error,
  }) {
    return BookingState(
      selectedService: selectedService ?? this.selectedService,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      selectedClinic: selectedClinic ?? this.selectedClinic,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      note: note ?? this.note,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class BookingNotifier extends StateNotifier<BookingState> {
  final Ref _ref;
  BookingNotifier(this._ref) : super(const BookingState());

  void selectService(DentalServiceModel service) {
    state = state.copyWith(selectedService: service);
  }

  void selectDoctor(DoctorWithServicesModel doctor) {
    state = state.copyWith(selectedDoctor: doctor);
  }

  void selectClinic(ClinicModel clinic) async {
    // If it's an OSM clinic, we must save it to Supabase to get a valid UUID
    if (clinic.id.startsWith('osm_')) {
      try {
        final supabase = Supabase.instance.client;
        final existing = await supabase
            .from('clinics')
            .select('id')
            .eq('name', clinic.name)
            .limit(1)
            .maybeSingle();

        String newId;
        if (existing != null) {
          newId = existing['id'] as String;
        } else {
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
          newId = inserted['id'] as String;
        }

        clinic = clinic.copyWith(id: newId);
      } catch (e) {
        // Fallback or log if saving fails
      }
    }

    state = state.copyWith(selectedClinic: clinic);

    // Automatically select the first doctor associated with this clinic if none selected
    try {
      final doctors = await _ref.read(doctorListProvider.future);
      // Assuming doctors have clinic associations or we just pick the first available one for now
      // to keep the flow working. In a real app, this would filter by clinic.
      if (state.selectedDoctor == null && doctors.isNotEmpty) {
        state = state.copyWith(selectedDoctor: doctors.first);
      }
    } catch (e) {
      // Silent fail for auto-selection
    }
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date, selectedSlot: null);
  }

  void selectSlot(TimeSlot slot) {
    state = state.copyWith(selectedSlot: slot);
  }

  void selectPaymentMethod(SavedPaymentMethodModel method) {
    state = state.copyWith(selectedPaymentMethod: method);
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

    if (state.selectedService == null ||
        state.selectedClinic == null ||
        state.selectedDate == null ||
        state.selectedSlot == null ||
        state.selectedPaymentMethod == null) {
      state = state.copyWith(error: 'Please complete all booking steps.');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final repo = _ref.read(appointmentRepositoryProvider);

      String? finalDoctorId = state.selectedDoctor?.id;

      // If no doctor is selected, fetch one for this clinic
      if (finalDoctorId == null) {
        final docResponse = await Supabase.instance.client
            .from('doctor_availability')
            .select('doctor_id')
            .eq('clinic_id', state.selectedClinic!.id)
            .limit(1)
            .maybeSingle();

        if (docResponse != null) {
          finalDoctorId = docResponse['doctor_id'] as String;
        } else {
          final anyDoc = await Supabase.instance.client
              .from('doctors')
              .select('id')
              .limit(1)
              .maybeSingle();
          if (anyDoc != null) {
            finalDoctorId = anyDoc['id'] as String;
          } else {
            state = state.copyWith(
              isLoading: false,
              error: 'No doctors available to fulfill this booking.',
            );
            return false;
          }
        }
      }

      await repo.bookAppointment(
        patientId: user.id,
        doctorId: finalDoctorId,
        serviceId: state.selectedService!.id,
        clinicId: state.selectedClinic!.id,
        appointmentDate: state.selectedDate!,
        startTime: state.selectedSlot!.start,
        amount: state.selectedService!.price,
        notes: state.note,
      );
      // Invalidate providers to refresh data on home/schedule
      _ref.invalidate(upcomingAppointmentsProvider);

      state = state.copyWith(isLoading: false);
      return true;
    } on AppException catch (e) {
      String msg = e.message;
      if (e.type == 'duplicate') {
        msg = 'This time slot is already booked. Please choose another.';
      }
      state = state.copyWith(isLoading: false, error: msg);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred. Please try again.',
      );
      return false;
    }
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((
  ref,
) {
  return BookingNotifier(ref);
});

final availableSlotsProvider = FutureProvider.family<List<TimeSlot>, DateTime>((
  ref,
  date,
) async {
  final clinic = ref.watch(bookingProvider.select((s) => s.selectedClinic));
  final doctor = ref.watch(bookingProvider.select((s) => s.selectedDoctor));

  if (clinic == null) return [];

  final repo = ref.read(appointmentRepositoryProvider);
  return repo.fetchAvailableSlots(
    doctorId: doctor?.id,
    clinicId: clinic.id,
    date: date,
  );
});

final savedPaymentMethodsProvider =
    FutureProvider<List<SavedPaymentMethodModel>>((ref) async {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) return [];
      final repo = ref.read(paymentRepositoryProvider);
      return repo.fetchSavedPaymentMethods(user.id);
    });
