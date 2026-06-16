// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor_schedule_model.freezed.dart';
part 'doctor_schedule_model.g.dart';

@freezed
class DoctorScheduleModel with _$DoctorScheduleModel {
  const factory DoctorScheduleModel({
    required String id,
    @JsonKey(name: 'doctor_id') required String doctorId,
    @JsonKey(name: 'day_of_week') required String dayOfWeek,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
  }) = _DoctorScheduleModel;

  factory DoctorScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorScheduleModelFromJson(json);
}
