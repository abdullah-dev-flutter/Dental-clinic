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
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      isVerified: json['is_verified'] as bool? ?? false,
      addedByDoctorId: json['added_by_doctor_id'] as String?,
      isNewClinic: json['is_new_clinic'] as bool? ?? false,
      totalDoctors: (json['total_doctors'] as num?)?.toInt(),
      avgRating: (json['avg_rating'] as num?)?.toDouble(),
      minFee: (json['min_fee'] as num?)?.toDouble(),
      distanceKm: (json['distance_km'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ClinicModelImplToJson(_$ClinicModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'is_verified': instance.isVerified,
      'added_by_doctor_id': instance.addedByDoctorId,
      'is_new_clinic': instance.isNewClinic,
      'total_doctors': instance.totalDoctors,
      'avg_rating': instance.avgRating,
      'min_fee': instance.minFee,
      'distance_km': instance.distanceKm,
    };
