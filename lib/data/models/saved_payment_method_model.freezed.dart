// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_payment_method_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavedPaymentMethodModel _$SavedPaymentMethodModelFromJson(
  Map<String, dynamic> json,
) {
  return _SavedPaymentMethodModel.fromJson(json);
}

/// @nodoc
mixin _$SavedPaymentMethodModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_id')
  String get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'method_type')
  String get methodType => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;

  /// Serializes this SavedPaymentMethodModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedPaymentMethodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedPaymentMethodModelCopyWith<SavedPaymentMethodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedPaymentMethodModelCopyWith<$Res> {
  factory $SavedPaymentMethodModelCopyWith(
    SavedPaymentMethodModel value,
    $Res Function(SavedPaymentMethodModel) then,
  ) = _$SavedPaymentMethodModelCopyWithImpl<$Res, SavedPaymentMethodModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'patient_id') String patientId,
    @JsonKey(name: 'method_type') String methodType,
    String label,
    @JsonKey(name: 'is_default') bool isDefault,
  });
}

/// @nodoc
class _$SavedPaymentMethodModelCopyWithImpl<
  $Res,
  $Val extends SavedPaymentMethodModel
>
    implements $SavedPaymentMethodModelCopyWith<$Res> {
  _$SavedPaymentMethodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedPaymentMethodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? methodType = null,
    Object? label = null,
    Object? isDefault = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            patientId: null == patientId
                ? _value.patientId
                : patientId // ignore: cast_nullable_to_non_nullable
                      as String,
            methodType: null == methodType
                ? _value.methodType
                : methodType // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavedPaymentMethodModelImplCopyWith<$Res>
    implements $SavedPaymentMethodModelCopyWith<$Res> {
  factory _$$SavedPaymentMethodModelImplCopyWith(
    _$SavedPaymentMethodModelImpl value,
    $Res Function(_$SavedPaymentMethodModelImpl) then,
  ) = __$$SavedPaymentMethodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'patient_id') String patientId,
    @JsonKey(name: 'method_type') String methodType,
    String label,
    @JsonKey(name: 'is_default') bool isDefault,
  });
}

/// @nodoc
class __$$SavedPaymentMethodModelImplCopyWithImpl<$Res>
    extends
        _$SavedPaymentMethodModelCopyWithImpl<
          $Res,
          _$SavedPaymentMethodModelImpl
        >
    implements _$$SavedPaymentMethodModelImplCopyWith<$Res> {
  __$$SavedPaymentMethodModelImplCopyWithImpl(
    _$SavedPaymentMethodModelImpl _value,
    $Res Function(_$SavedPaymentMethodModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedPaymentMethodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? methodType = null,
    Object? label = null,
    Object? isDefault = null,
  }) {
    return _then(
      _$SavedPaymentMethodModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        methodType: null == methodType
            ? _value.methodType
            : methodType // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedPaymentMethodModelImpl implements _SavedPaymentMethodModel {
  const _$SavedPaymentMethodModelImpl({
    required this.id,
    @JsonKey(name: 'patient_id') required this.patientId,
    @JsonKey(name: 'method_type') required this.methodType,
    required this.label,
    @JsonKey(name: 'is_default') this.isDefault = false,
  });

  factory _$SavedPaymentMethodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedPaymentMethodModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'patient_id')
  final String patientId;
  @override
  @JsonKey(name: 'method_type')
  final String methodType;
  @override
  final String label;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;

  @override
  String toString() {
    return 'SavedPaymentMethodModel(id: $id, patientId: $patientId, methodType: $methodType, label: $label, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedPaymentMethodModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.methodType, methodType) ||
                other.methodType == methodType) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, patientId, methodType, label, isDefault);

  /// Create a copy of SavedPaymentMethodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedPaymentMethodModelImplCopyWith<_$SavedPaymentMethodModelImpl>
  get copyWith =>
      __$$SavedPaymentMethodModelImplCopyWithImpl<
        _$SavedPaymentMethodModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedPaymentMethodModelImplToJson(this);
  }
}

abstract class _SavedPaymentMethodModel implements SavedPaymentMethodModel {
  const factory _SavedPaymentMethodModel({
    required final String id,
    @JsonKey(name: 'patient_id') required final String patientId,
    @JsonKey(name: 'method_type') required final String methodType,
    required final String label,
    @JsonKey(name: 'is_default') final bool isDefault,
  }) = _$SavedPaymentMethodModelImpl;

  factory _SavedPaymentMethodModel.fromJson(Map<String, dynamic> json) =
      _$SavedPaymentMethodModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'patient_id')
  String get patientId;
  @override
  @JsonKey(name: 'method_type')
  String get methodType;
  @override
  String get label;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;

  /// Create a copy of SavedPaymentMethodModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedPaymentMethodModelImplCopyWith<_$SavedPaymentMethodModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
