// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_payment_method_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedPaymentMethodModelImpl _$$SavedPaymentMethodModelImplFromJson(
  Map<String, dynamic> json,
) => _$SavedPaymentMethodModelImpl(
  id: json['id'] as String,
  patientId: json['patient_id'] as String,
  methodType: json['method_type'] as String,
  label: json['label'] as String,
  isDefault: json['is_default'] as bool? ?? false,
);

Map<String, dynamic> _$$SavedPaymentMethodModelImplToJson(
  _$SavedPaymentMethodModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient_id': instance.patientId,
  'method_type': instance.methodType,
  'label': instance.label,
  'is_default': instance.isDefault,
};
