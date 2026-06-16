// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dental_service_model.freezed.dart';
part 'dental_service_model.g.dart';

@freezed
class DentalServiceModel with _$DentalServiceModel {
  const factory DentalServiceModel({
    required String id,
    required String name,
    String? description,
    required double price,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'icon_url') String? iconUrl,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _DentalServiceModel;

  factory DentalServiceModel.fromJson(Map<String, dynamic> json) => _$DentalServiceModelFromJson(json);
}
