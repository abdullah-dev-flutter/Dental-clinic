// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_verification_model.freezed.dart';
part 'doctor_verification_model.g.dart';

@freezed
class DoctorVerificationModel with _$DoctorVerificationModel {
  const factory DoctorVerificationModel({
    required String id, // Doctor ID
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    String? phone,
    String? specialization,
    @JsonKey(name: 'pmdc_number') required String pmdcNumber,
    @JsonKey(name: 'experience_years') int? experienceYears,
    @JsonKey(name: 'consultation_fee') double? consultationFee,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
    @Default('pending') String status,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    // Document Fields (joined from doctor_verifications)
    @JsonKey(name: 'pmdc_license_url') String? pmdcLicenseUrl,
    @JsonKey(name: 'degree_url') String? degreeUrl,
    @JsonKey(name: 'cnic_url') String? cnicUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _DoctorVerificationModel;

  factory DoctorVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorVerificationModelFromJson(json);
}
