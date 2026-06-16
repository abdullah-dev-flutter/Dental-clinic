// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_payment_method_model.freezed.dart';
part 'saved_payment_method_model.g.dart';

@freezed
class SavedPaymentMethodModel with _$SavedPaymentMethodModel {
  const factory SavedPaymentMethodModel({
    required String id,
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'method_type') required String methodType,
    required String label,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
  }) = _SavedPaymentMethodModel;

  factory SavedPaymentMethodModel.fromJson(Map<String, dynamic> json) => _$SavedPaymentMethodModelFromJson(json);
}
