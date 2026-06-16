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
    @JsonKey(name: 'opening_time') String? openingTime,
    @JsonKey(name: 'closing_time') String? closingTime,
    @JsonKey(name: 'lat') double? lat,
    @JsonKey(name: 'lng') double? lng,
  }) = _ClinicModel;

  factory ClinicModel.fromJson(Map<String, dynamic> json) => _$ClinicModelFromJson(json);
}
