// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorModelImpl _$$DoctorModelImplFromJson(Map<String, dynamic> json) =>
    _$DoctorModelImpl(
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
    );

Map<String, dynamic> _$$DoctorModelImplToJson(_$DoctorModelImpl instance) =>
    <String, dynamic>{
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
    };
