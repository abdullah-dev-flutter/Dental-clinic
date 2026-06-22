// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorVerificationModelImpl _$$DoctorVerificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$DoctorVerificationModelImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  fullName: json['full_name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  specialization: json['specialization'] as String?,
  pmdcNumber: json['pmdc_number'] as String,
  experienceYears: (json['experience_years'] as num?)?.toInt(),
  consultationFee: (json['consultation_fee'] as num?)?.toDouble(),
  profileImageUrl: json['profile_image_url'] as String?,
  clinicName: json['clinic_name'] as String?,
  clinicAddress: json['clinic_address'] as String?,
  status: json['status'] as String? ?? 'pending',
  rejectionReason: json['rejection_reason'] as String?,
  pmdcLicenseUrl: json['pmdc_license_url'] as String?,
  degreeUrl: json['degree_url'] as String?,
  cnicUrl: json['cnic_url'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$DoctorVerificationModelImplToJson(
  _$DoctorVerificationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'specialization': instance.specialization,
  'pmdc_number': instance.pmdcNumber,
  'experience_years': instance.experienceYears,
  'consultation_fee': instance.consultationFee,
  'profile_image_url': instance.profileImageUrl,
  'clinic_name': instance.clinicName,
  'clinic_address': instance.clinicAddress,
  'status': instance.status,
  'rejection_reason': instance.rejectionReason,
  'pmdc_license_url': instance.pmdcLicenseUrl,
  'degree_url': instance.degreeUrl,
  'cnic_url': instance.cnicUrl,
  'created_at': instance.createdAt.toIso8601String(),
};
