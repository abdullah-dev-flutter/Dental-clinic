// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClinicLocationModelImpl _$$ClinicLocationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClinicLocationModelImpl(
      clinicName: json['clinic_name'] as String,
      clinicAddress: json['clinic_address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      isExistingClinic: json['is_existing_clinic'] as bool?,
      existingClinicId: json['existing_clinic_id'] as String?,
    );

Map<String, dynamic> _$$ClinicLocationModelImplToJson(
        _$ClinicLocationModelImpl instance) =>
    <String, dynamic>{
      'clinic_name': instance.clinicName,
      'clinic_address': instance.clinicAddress,
      'lat': instance.lat,
      'lng': instance.lng,
      'is_existing_clinic': instance.isExistingClinic,
      'existing_clinic_id': instance.existingClinicId,
    };
