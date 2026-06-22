// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorModelImpl _$$DoctorModelImplFromJson(Map<String, dynamic> json) =>
    _$DoctorModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      specialization: json['specialization'] as String?,
      pmdcNumber: json['pmdc_number'] as String,
      experienceYears: (json['experience_years'] as num?)?.toInt(),
      consultationFee: (json['consultation_fee'] as num?)?.toDouble(),
      bio: json['bio'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      clinicName: json['clinic_name'] as String?,
      clinicAddress: json['clinic_address'] as String?,
      clinicLat: (json['clinic_lat'] as num?)?.toDouble(),
      clinicLng: (json['clinic_lng'] as num?)?.toDouble(),
      isAvailable: json['is_available'] as bool? ?? true,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
      totalPatients: (json['total_patients'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'pending',
      rejectionReason: json['rejection_reason'] as String?,
    );

Map<String, dynamic> _$$DoctorModelImplToJson(_$DoctorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'specialization': instance.specialization,
      'pmdc_number': instance.pmdcNumber,
      'experience_years': instance.experienceYears,
      'consultation_fee': instance.consultationFee,
      'bio': instance.bio,
      'profile_image_url': instance.profileImageUrl,
      'clinic_name': instance.clinicName,
      'clinic_address': instance.clinicAddress,
      'clinic_lat': instance.clinicLat,
      'clinic_lng': instance.clinicLng,
      'is_available': instance.isAvailable,
      'rating': instance.rating,
      'total_reviews': instance.totalReviews,
      'total_patients': instance.totalPatients,
      'status': instance.status,
      'rejection_reason': instance.rejectionReason,
    };
