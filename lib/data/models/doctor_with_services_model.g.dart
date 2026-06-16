// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_with_services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorWithServicesModelImpl _$$DoctorWithServicesModelImplFromJson(
  Map<String, dynamic> json,
) => _$DoctorWithServicesModelImpl(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  specialty: json['specialty'] as String,
  qualification: json['qualification'] as String?,
  bio: json['bio'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
  isOnline: json['is_online'] as bool? ?? false,
  experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
  consultationFee: (json['consultation_fee'] as num?)?.toDouble() ?? 0.0,
  isActive: json['is_active'] as bool? ?? false,
  serviceCount: (json['service_count'] as num?)?.toInt() ?? 0,
  serviceIds: json['service_ids'] == null
      ? const []
      : _serviceIdsFromJson(json['service_ids']),
);

Map<String, dynamic> _$$DoctorWithServicesModelImplToJson(
  _$DoctorWithServicesModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'specialty': instance.specialty,
  'qualification': instance.qualification,
  'bio': instance.bio,
  'avatar_url': instance.avatarUrl,
  'rating': instance.rating,
  'review_count': instance.reviewCount,
  'is_online': instance.isOnline,
  'experience_years': instance.experienceYears,
  'consultation_fee': instance.consultationFee,
  'is_active': instance.isActive,
  'service_count': instance.serviceCount,
  'service_ids': _serviceIdsToJson(instance.serviceIds),
};
