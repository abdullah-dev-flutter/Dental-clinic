// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(Map<String, dynamic> json) =>
    _$PaymentModelImpl(
      id: json['id'] as String,
      appointmentId: json['appointment_id'] as String,
      patientId: json['patient_id'] as String,
      doctorId: json['doctor_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      platformFee: (json['platform_fee'] as num?)?.toDouble(),
      doctorEarning: (json['doctor_earning'] as num?)?.toDouble(),
      paymentMethod: json['payment_method'] as String?,
      transactionId: json['transaction_id'] as String?,
      status: json['status'] as String? ?? 'pending',
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
    );

Map<String, dynamic> _$$PaymentModelImplToJson(_$PaymentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointment_id': instance.appointmentId,
      'patient_id': instance.patientId,
      'doctor_id': instance.doctorId,
      'amount': instance.amount,
      'platform_fee': instance.platformFee,
      'doctor_earning': instance.doctorEarning,
      'payment_method': instance.paymentMethod,
      'transaction_id': instance.transactionId,
      'status': instance.status,
      'paid_at': instance.paidAt?.toIso8601String(),
    };
