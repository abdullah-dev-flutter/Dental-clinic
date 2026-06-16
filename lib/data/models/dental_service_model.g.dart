// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dental_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DentalServiceModelImpl _$$DentalServiceModelImplFromJson(
  Map<String, dynamic> json,
) => _$DentalServiceModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  iconUrl: json['icon_url'] as String?,
  category: json['category'] as String?,
  isActive: json['is_active'] as bool? ?? true,
);

Map<String, dynamic> _$$DentalServiceModelImplToJson(
  _$DentalServiceModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'duration_minutes': instance.durationMinutes,
  'icon_url': instance.iconUrl,
  'category': instance.category,
  'is_active': instance.isActive,
};
