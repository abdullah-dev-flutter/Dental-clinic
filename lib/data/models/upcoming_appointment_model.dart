// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_appointment_model.freezed.dart';
part 'upcoming_appointment_model.g.dart';

@freezed
class UpcomingAppointmentModel with _$UpcomingAppointmentModel {
  const UpcomingAppointmentModel._();

  const factory UpcomingAppointmentModel({
    required String id,
    @JsonKey(name: 'patient_id') String? patientId,
    @JsonKey(name: 'patient_phone') String? patientPhone,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'appointment_date') required DateTime appointmentDate,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    required String status,
    double? cost,
    @JsonKey(name: 'services_selected') List<Map<String, dynamic>>? servicesSelected,
    String? service,

    // Joined fields from view
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'doctor_avatar') String? doctorAvatar,
    @JsonKey(name: 'doctor_specialty') String? doctorSpecialty,
    
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'service_icon') String? serviceIcon,
    @JsonKey(name: 'service_price') double? servicePrice,

    @JsonKey(name: 'clinic_id') String? clinicId,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
  }) = _UpcomingAppointmentModel;

  factory UpcomingAppointmentModel.fromJson(Map<String, dynamic> json) => _$UpcomingAppointmentModelFromJson(json);
}
