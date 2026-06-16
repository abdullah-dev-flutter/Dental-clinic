// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_model.freezed.dart';
part 'doctor_model.g.dart';

@freezed
class DoctorModel with _$DoctorModel {
  const factory DoctorModel({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    required String specialty,
    String? qualification,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @Default(0.0) double rating,
    @JsonKey(name: 'review_count') @Default(0) int reviewCount,
    @JsonKey(name: 'is_online') @Default(false) bool isOnline,
    @JsonKey(name: 'experience_years') @Default(0) int experienceYears,
    @JsonKey(name: 'consultation_fee') @Default(0.0) double consultationFee,
    @JsonKey(name: 'is_active') @Default(false) bool isActive,
  }) = _DoctorModel;

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
}
