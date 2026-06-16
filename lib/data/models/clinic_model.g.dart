// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicModelImpl _$$ClinicModelImplFromJson(Map<String, dynamic> json) =>
    _$ClinicModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      openingTime: json['opening_time'] as String?,
      closingTime: json['closing_time'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ClinicModelImplToJson(_$ClinicModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'opening_time': instance.openingTime,
      'closing_time': instance.closingTime,
      'lat': instance.lat,
      'lng': instance.lng,
    };
