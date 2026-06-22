// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required String id,
    @JsonKey(name: 'appointment_id') required String appointmentId,
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'doctor_id') required String doctorId,
    required double amount,
    @JsonKey(name: 'platform_fee') double? platformFee,
    @JsonKey(name: 'doctor_earning') double? doctorEarning,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'transaction_id') String? transactionId,
    @Default('pending') String status,
    @JsonKey(name: 'paid_at') DateTime? paidAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}
