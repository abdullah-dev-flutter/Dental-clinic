// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationModelImpl(
  id: json['id'] as String,
  patientId: json['patient_id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  type: json['type'] as String,
  isRead: json['is_read'] as bool? ?? false,
  appointmentId: json['appointment_id'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$NotificationModelImplToJson(
  _$NotificationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patientId,
  'title': instance.title,
  'body': instance.body,
  'type': instance.type,
  'is_read': instance.isRead,
  'appointment_id': instance.appointmentId,
  'created_at': instance.createdAt.toIso8601String(),
};
