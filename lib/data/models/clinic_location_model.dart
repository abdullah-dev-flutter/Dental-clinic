// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic_location_model.freezed.dart';
part 'clinic_location_model.g.dart';

@freezed
class ClinicLocationModel with _$ClinicLocationModel {
  const factory ClinicLocationModel({
    required String clinicName,
    required String clinicAddress,
    required double lat,
    required double lng,
    bool? isExistingClinic,
    String? existingClinicId,
  }) = _ClinicLocationModel;

  factory ClinicLocationModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicLocationModelFromJson(json);
}
