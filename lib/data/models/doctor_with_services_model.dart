// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_with_services_model.freezed.dart';
part 'doctor_with_services_model.g.dart';

@freezed
class DoctorWithServicesModel with _$DoctorWithServicesModel {
  const factory DoctorWithServicesModel({
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
    @JsonKey(name: 'service_count') @Default(0) int serviceCount,
    @JsonKey(name: 'service_ids', fromJson: _serviceIdsFromJson, toJson: _serviceIdsToJson)
    @Default([])
    List<String> serviceIds,
  }) = _DoctorWithServicesModel;

  factory DoctorWithServicesModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorWithServicesModelFromJson(json);
}

List<String> _serviceIdsFromJson(Object? value) {
  final ids = value as List<dynamic>?;
  if (ids == null) {
    return const [];
  }

  return ids.whereType<String>().where((id) => id.isNotEmpty).toList(growable: false);
}

List<String> _serviceIdsToJson(List<String> value) => value;
