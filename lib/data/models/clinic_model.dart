// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_model.freezed.dart';
part 'clinic_model.g.dart';

@freezed
class ClinicModel with _$ClinicModel {
  const factory ClinicModel({
    required String id,
    required String name,
    required String address,
    required double lat,
    required double lng,
    @Default(false) bool isVerified,
    @JsonKey(name: 'added_by_doctor_id') String? addedByDoctorId,
    @Default(false) bool isNewClinic,
    int? totalDoctors,
    double? avgRating,
    double? minFee,
    double? distanceKm,
  }) = _ClinicModel;

  factory ClinicModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicModelFromJson(json);
}
