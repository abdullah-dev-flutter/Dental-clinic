// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      doctorId: json['doctor_id'] as String,
      appointmentId: json['appointment_id'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      profile: json['profiles'] == null
          ? null
          : ProfileSimple.fromJson(json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patientId,
      'doctor_id': instance.doctorId,
      'appointment_id': instance.appointmentId,
      'rating': instance.rating,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
      'profiles': instance.profile,
    };

_$ProfileSimpleImpl _$$ProfileSimpleImplFromJson(Map<String, dynamic> json) =>
    _$ProfileSimpleImpl(
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$$ProfileSimpleImplToJson(_$ProfileSimpleImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'avatar_url': instance.avatarUrl,
    };
