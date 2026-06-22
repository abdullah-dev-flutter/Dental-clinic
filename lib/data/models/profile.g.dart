// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      fullName: json['full_name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      onboardingDone: json['onboarding_done'] as bool? ?? false,
      role: json['role'] as String? ?? 'patient',
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'avatar_url': instance.avatarUrl,
      'onboarding_done': instance.onboardingDone,
      'role': instance.role,
    };
