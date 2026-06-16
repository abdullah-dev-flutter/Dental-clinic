// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DoctorScheduleModelImpl _$$DoctorScheduleModelImplFromJson(
  Map<String, dynamic> json,
) => _$DoctorScheduleModelImpl(
  id: json['id'] as String,
  doctorId: json['doctor_id'] as String,
  dayOfWeek: json['day_of_week'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  isAvailable: json['is_available'] as bool? ?? true,
);

Map<String, dynamic> _$$DoctorScheduleModelImplToJson(
  _$DoctorScheduleModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'doctor_id': instance.doctorId,
  'day_of_week': instance.dayOfWeek,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'is_available': instance.isAvailable,
};
