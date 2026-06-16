// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'doctor_id') required String doctorId,
    @JsonKey(name: 'appointment_id') required String appointmentId,
    required int rating,
    String? comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    // Joined profile
    @JsonKey(name: 'profiles') ProfileSimple? profile,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

@freezed
class ProfileSimple with _$ProfileSimple {
  const factory ProfileSimple({
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ProfileSimple;

  factory ProfileSimple.fromJson(Map<String, dynamic> json) =>
      _$ProfileSimpleFromJson(json);
}
