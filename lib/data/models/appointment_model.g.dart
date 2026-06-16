// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppointmentModelImpl _$$AppointmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AppointmentModelImpl(
  id: json['id'] as String,
  patientId: json['patient_id'] as String,
  doctorId: json['doctor_id'] as String,
  serviceId: json['service_id'] as String,
  clinicId: json['clinic_id'] as String,
  appointmentDate: DateTime.parse(json['appointment_date'] as String),
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  status: json['status'] as String,
  notes: json['notes'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$AppointmentModelImplToJson(
  _$AppointmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patientId,
  'doctor_id': instance.doctorId,
  'service_id': instance.serviceId,
  'clinic_id': instance.clinicId,
  'appointment_date': instance.appointmentDate.toIso8601String(),
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'status': instance.status,
  'notes': instance.notes,
  'created_at': instance.createdAt?.toIso8601String(),
};
