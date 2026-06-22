// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClinicLocationModel _$ClinicLocationModelFromJson(Map<String, dynamic> json) {
  return _ClinicLocationModel.fromJson(json);
}

/// @nodoc
mixin _$ClinicLocationModel {
  String get clinicName => throw _privateConstructorUsedError;
  String get clinicAddress => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  bool? get isExistingClinic => throw _privateConstructorUsedError;
  String? get existingClinicId => throw _privateConstructorUsedError;

  /// Serializes this ClinicLocationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClinicLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicLocationModelCopyWith<ClinicLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicLocationModelCopyWith<$Res> {
  factory $ClinicLocationModelCopyWith(
          ClinicLocationModel value, $Res Function(ClinicLocationModel) then) =
      _$ClinicLocationModelCopyWithImpl<$Res, ClinicLocationModel>;
  @useResult
  $Res call({
    String clinicName,
    String clinicAddress,
    double lat,
    double lng,
    bool? isExistingClinic,
    String? existingClinicId,
  });
}

/// @nodoc
class _$ClinicLocationModelCopyWithImpl<$Res, $Val extends ClinicLocationModel>
    implements $ClinicLocationModelCopyWith<$Res> {
  _$ClinicLocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicName = null,
    Object? clinicAddress = null,
    Object? lat = null,
    Object? lng = null,
    Object? isExistingClinic = freezed,
    Object? existingClinicId = freezed,
  }) {
    return _then(_value.copyWith(
      clinicName: null == clinicName
          ? _value.clinicName
          : clinicName // ignore: cast_nullable_to_non_nullable
                as String,
      clinicAddress: null == clinicAddress
          ? _value.clinicAddress
          : clinicAddress // ignore: cast_nullable_to_non_nullable
                as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
                as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
                as double,
      isExistingClinic: freezed == isExistingClinic
          ? _value.isExistingClinic
          : isExistingClinic // ignore: cast_nullable_to_non_nullable
                as bool?,
      existingClinicId: freezed == existingClinicId
          ? _value.existingClinicId
          : existingClinicId // ignore: cast_nullable_to_non_nullable
                as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClinicLocationModelImplCopyWith<$Res>
    implements $ClinicLocationModelCopyWith<$Res> {
  factory _$$ClinicLocationModelImplCopyWith(_$ClinicLocationModelImpl value,
          $Res Function(_$ClinicLocationModelImpl) then) =
      __$$ClinicLocationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String clinicName,
    String clinicAddress,
    double lat,
    double lng,
    bool? isExistingClinic,
    String? existingClinicId,
  });
}

/// @nodoc
class __$$ClinicLocationModelImplCopyWithImpl<$Res>
    extends _$ClinicLocationModelCopyWithImpl<$Res, _$ClinicLocationModelImpl>
    implements _$$ClinicLocationModelImplCopyWith<$Res> {
  __$$ClinicLocationModelImplCopyWithImpl(_$ClinicLocationModelImpl _value,
      $Res Function(_$ClinicLocationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicName = null,
    Object? clinicAddress = null,
    Object? lat = null,
    Object? lng = null,
    Object? isExistingClinic = freezed,
    Object? existingClinicId = freezed,
  }) {
    return _then(_$ClinicLocationModelImpl(
      clinicName: null == clinicName
          ? _value.clinicName
          : clinicName // ignore: cast_nullable_to_non_nullable
                as String,
      clinicAddress: null == clinicAddress
          ? _value.clinicAddress
          : clinicAddress // ignore: cast_nullable_to_non_nullable
                as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
                as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
                as double,
      isExistingClinic: freezed == isExistingClinic
          ? _value.isExistingClinic
          : isExistingClinic // ignore: cast_nullable_to_non_nullable
                as bool?,
      existingClinicId: freezed == existingClinicId
          ? _value.existingClinicId
          : existingClinicId // ignore: cast_nullable_to_non_nullable
                as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClinicLocationModelImpl implements _ClinicLocationModel {
  const _$ClinicLocationModelImpl({
    required this.clinicName,
    required this.clinicAddress,
    required this.lat,
    required this.lng,
    this.isExistingClinic,
    this.existingClinicId,
  });

  factory _$ClinicLocationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClinicLocationModelImplFromJson(json);

  @override
  final String clinicName;
  @override
  final String clinicAddress;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final bool? isExistingClinic;
  @override
  final String? existingClinicId;

  @override
  String toString() {
    return 'ClinicLocationModel(clinicName: $clinicName, clinicAddress: $clinicAddress, lat: $lat, lng: $lng, isExistingClinic: $isExistingClinic, existingClinicId: $existingClinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicLocationModelImpl &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName) &&
            (identical(other.clinicAddress, clinicAddress) ||
                other.clinicAddress == clinicAddress) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.isExistingClinic, isExistingClinic) ||
                other.isExistingClinic == isExistingClinic) &&
            (identical(other.existingClinicId, existingClinicId) ||
                other.existingClinicId == existingClinicId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
        runtimeType,
        clinicName,
        clinicAddress,
        lat,
        lng,
        isExistingClinic,
        existingClinicId,
      );

  /// Create a copy of ClinicLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicLocationModelImplCopyWith<_$ClinicLocationModelImpl> get copyWith =>
      __$$ClinicLocationModelImplCopyWithImpl<_$ClinicLocationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClinicLocationModelImplToJson(this);
  }
}

abstract class _ClinicLocationModel implements ClinicLocationModel {
  const factory _ClinicLocationModel({
    required final String clinicName,
    required final String clinicAddress,
    required final double lat,
    required final double lng,
    final bool? isExistingClinic,
    final String? existingClinicId,
  }) = _$ClinicLocationModelImpl;

  factory _ClinicLocationModel.fromJson(Map<String, dynamic> json) =
      _$ClinicLocationModelImpl.fromJson;

  @override
  String get clinicName;
  @override
  String get clinicAddress;
  @override
  double get lat;
  @override
  double get lng;
  @override
  bool? get isExistingClinic;
  @override
  String? get existingClinicId;

  /// Create a copy of ClinicLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicLocationModelImplCopyWith<_$ClinicLocationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
