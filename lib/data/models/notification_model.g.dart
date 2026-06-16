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
  message: json['message'] as String,
  type: json['notification_type'] as String,
  isRead: json['is_read'] as bool? ?? false,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$NotificationModelImplToJson(
  _$NotificationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patientId,
  'title': instance.title,
  'message': instance.message,
  'notification_type': instance.type,
  'is_read': instance.isRead,
  'created_at': instance.createdAt.toIso8601String(),
};
