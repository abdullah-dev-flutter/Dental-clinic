// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpcomingAppointmentModelImpl _$$UpcomingAppointmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$UpcomingAppointmentModelImpl(
  id: json['id'] as String,
  patientId: json['patient_id'] as String?,
  patientPhone: json['patient_phone'] as String?,
  patientName: json['patient_name'] as String?,
  appointmentDate: DateTime.parse(json['appointment_date'] as String),
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  paymentMethod: json['payment_method'] as String?,
  status: json['status'] as String,
  cost: (json['cost'] as num?)?.toDouble(),
  servicesSelected: (json['services_selected'] as List<dynamic>?)
      ?.map((e) => e as Map<String, dynamic>)
      .toList(),
  service: json['service'] as String?,
  doctorId: json['doctor_id'] as String?,
  doctorName: json['doctor_name'] as String?,
  doctorAvatar: json['doctor_avatar'] as String?,
  doctorSpecialty: json['doctor_specialty'] as String?,
  serviceId: json['service_id'] as String?,
  serviceName: json['service_name'] as String?,
  serviceIcon: json['service_icon'] as String?,
  servicePrice: (json['service_price'] as num?)?.toDouble(),
  clinicId: json['clinic_id'] as String?,
  clinicName: json['clinic_name'] as String?,
  clinicAddress: json['clinic_address'] as String?,
);

Map<String, dynamic> _$$UpcomingAppointmentModelImplToJson(
  _$UpcomingAppointmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patientId,
  'patient_phone': instance.patientPhone,
  'patient_name': instance.patientName,
  'appointment_date': instance.appointmentDate.toIso8601String(),
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'payment_method': instance.paymentMethod,
  'status': instance.status,
  'cost': instance.cost,
  'services_selected': instance.servicesSelected,
  'service': instance.service,
  'doctor_id': instance.doctorId,
  'doctor_name': instance.doctorName,
  'doctor_avatar': instance.doctorAvatar,
  'doctor_specialty': instance.doctorSpecialty,
  'service_id': instance.serviceId,
  'service_name': instance.serviceName,
  'service_icon': instance.serviceIcon,
  'service_price': instance.servicePrice,
  'clinic_id': instance.clinicId,
  'clinic_name': instance.clinicName,
  'clinic_address': instance.clinicAddress,
};
