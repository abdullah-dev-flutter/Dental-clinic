// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeSlotImpl _$$TimeSlotImplFromJson(Map<String, dynamic> json) =>
    _$TimeSlotImpl(
      start: json['slot_time'] as String,
      end: json['end'] as String? ?? '',
      available: json['available'] as bool? ?? true,
    );

Map<String, dynamic> _$$TimeSlotImplToJson(_$TimeSlotImpl instance) =>
    <String, dynamic>{
      'slot_time': instance.start,
      'end': instance.end,
      'available': instance.available,
    };
