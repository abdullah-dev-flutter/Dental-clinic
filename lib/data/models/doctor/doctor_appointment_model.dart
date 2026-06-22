// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import '../profile.dart';

part 'doctor_appointment_model.freezed.dart';
part 'doctor_appointment_model.g.dart';

@freezed
class DoctorAppointmentModel with _$DoctorAppointmentModel {
  const factory DoctorAppointmentModel({
    required String id,
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'doctor_id') required String doctorId,
    @JsonKey(name: 'appointment_date') required DateTime appointmentDate,
    @JsonKey(name: 'appointment_time') required String appointmentTime,
    @Default(30) int duration,
    @Default('pending') String status,
    @Default('consultation') String type,
    String? symptoms,
    String? notes,
    String? prescription,
    @JsonKey(name: 'total_amount') double? totalAmount,
    @JsonKey(name: 'payment_status') @Default('unpaid') String paymentStatus,
    @JsonKey(name: 'payment_id') String? paymentId,
    ProfileModel? patient, // Reusing existing ProfileModel for patient info
  }) = _DoctorAppointmentModel;

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentModelFromJson(json);
}
