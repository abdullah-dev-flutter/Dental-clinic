// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';
part 'appointment_model.g.dart';

@freezed
class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    required String id,
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'patient_phone') String? patientPhone,
    @JsonKey(name: 'patient_name') String? patientName,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'clinic_id') required String clinicId,
    @JsonKey(name: 'appointment_date') required DateTime appointmentDate,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    required String status,
    double? cost,
    @JsonKey(name: 'services_selected') List<Map<String, dynamic>>? servicesSelected,
    String? notes,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _AppointmentModel;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$AppointmentModelFromJson(json);
}
