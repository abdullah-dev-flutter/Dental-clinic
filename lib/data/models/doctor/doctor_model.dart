// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    String? phone,
    String? specialization,
    @JsonKey(name: 'pmdc_number') required String pmdcNumber,
    @JsonKey(name: 'experience_years') int? experienceYears,
    @JsonKey(name: 'consultation_fee') double? consultationFee,
    String? bio,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
    @JsonKey(name: 'clinic_lat') double? clinicLat,
    @JsonKey(name: 'clinic_lng') double? clinicLng,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @Default(0.0) double rating,
    @JsonKey(name: 'total_reviews') @Default(0) int totalReviews,
    @JsonKey(name: 'total_patients') @Default(0) int totalPatients,
    @Default('pending') String status,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
  }) = _DoctorModel;

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
}
