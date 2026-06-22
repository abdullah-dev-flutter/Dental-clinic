// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorAppointmentModelImpl _$$DoctorAppointmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$DoctorAppointmentModelImpl(
  id: json['id'] as String,
  patientId: json['patient_id'] as String,
  doctorId: json['doctor_id'] as String,
  appointmentDate: DateTime.parse(json['appointment_date'] as String),
  appointmentTime: json['appointment_time'] as String,
  duration: (json['duration'] as num?)?.toInt() ?? 30,
  status: json['status'] as String? ?? 'pending',
  type: json['type'] as String? ?? 'consultation',
  symptoms: json['symptoms'] as String?,
  notes: json['notes'] as String?,
  prescription: json['prescription'] as String?,
  totalAmount: (json['total_amount'] as num?)?.toDouble(),
  paymentStatus: json['payment_status'] as String? ?? 'unpaid',
  paymentId: json['payment_id'] as String?,
  patient: json['patient'] == null
      ? null
      : ProfileModel.fromJson(json['patient'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DoctorAppointmentModelImplToJson(
  _$DoctorAppointmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patientId,
  'doctor_id': instance.doctorId,
  'appointment_date': instance.appointmentDate.toIso8601String(),
  'appointment_time': instance.appointmentTime,
  'duration': instance.duration,
  'status': instance.status,
  'type': instance.type,
  'symptoms': instance.symptoms,
  'notes': instance.notes,
  'prescription': instance.prescription,
  'total_amount': instance.totalAmount,
  'payment_status': instance.paymentStatus,
  'payment_id': instance.paymentId,
  'patient': instance.patient,
};
