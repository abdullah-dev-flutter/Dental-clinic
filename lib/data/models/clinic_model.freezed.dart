// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ClinicModel _$ClinicModelFromJson(Map<String, dynamic> json) {
  return _ClinicModel.fromJson(json);
}

/// @nodoc
mixin _$ClinicModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  String? get addedByDoctorId => throw _privateConstructorUsedError;
  bool get isNewClinic => throw _privateConstructorUsedError;
  int? get totalDoctors => throw _privateConstructorUsedError;
  double? get avgRating => throw _privateConstructorUsedError;
  double? get minFee => throw _privateConstructorUsedError;
  double? get distanceKm => throw _privateConstructorUsedError;

  /// Serializes this ClinicModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicModelCopyWith<ClinicModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicModelCopyWith<$Res> {
  factory $ClinicModelCopyWith(ClinicModel value, $Res Function(ClinicModel) then) =
      _$ClinicModelCopyWithImpl<$Res, ClinicModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String address,
    double lat,
    double lng,
    bool isVerified,
    @JsonKey(name: 'added_by_doctor_id') String? addedByDoctorId,
    bool isNewClinic,
    int? totalDoctors,
    double? avgRating,
    double? minFee,
    double? distanceKm,
  });
}

/// @nodoc
class _$ClinicModelCopyWithImpl<$Res, $Val extends ClinicModel>
    implements $ClinicModelCopyWith<$Res> {
  _$ClinicModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? isVerified = null,
    Object? addedByDoctorId = freezed,
    Object? isNewClinic = null,
    Object? totalDoctors = freezed,
    Object? avgRating = freezed,
    Object? minFee = freezed,
    Object? distanceKm = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
                as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
                as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
                as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
                as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
                as double,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
                as bool,
      addedByDoctorId: freezed == addedByDoctorId
          ? _value.addedByDoctorId
          : addedByDoctorId // ignore: cast_nullable_to_non_nullable
                as String?,
      isNewClinic: null == isNewClinic
          ? _value.isNewClinic
          : isNewClinic // ignore: cast_nullable_to_non_nullable
                as bool,
      totalDoctors: freezed == totalDoctors
          ? _value.totalDoctors
          : totalDoctors // ignore: cast_nullable_to_non_nullable
                as int?,
      avgRating: freezed == avgRating
          ? _value.avgRating
          : avgRating // ignore: cast_nullable_to_non_nullable
                as double?,
      minFee: freezed == minFee
          ? _value.minFee
          : minFee // ignore: cast_nullable_to_non_nullable
                as double?,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
                as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClinicModelImplCopyWith<$Res>
    implements $ClinicModelCopyWith<$Res> {
  factory _$$ClinicModelImplCopyWith(
          _$ClinicModelImpl value, $Res Function(_$ClinicModelImpl) then) =
      __$$ClinicModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String address,
    double lat,
    double lng,
    bool isVerified,
    @JsonKey(name: 'added_by_doctor_id') String? addedByDoctorId,
    bool isNewClinic,
    int? totalDoctors,
    double? avgRating,
    double? minFee,
    double? distanceKm,
  });
}

/// @nodoc
class __$$ClinicModelImplCopyWithImpl<$Res>
    extends _$ClinicModelCopyWithImpl<$Res, _$ClinicModelImpl>
    implements _$$ClinicModelImplCopyWith<$Res> {
  __$$ClinicModelImplCopyWithImpl(
      _$ClinicModelImpl _value, $Res Function(_$ClinicModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? lat = null,
    Object? lng = null,
    Object? isVerified = null,
    Object? addedByDoctorId = freezed,
    Object? isNewClinic = null,
    Object? totalDoctors = freezed,
    Object? avgRating = freezed,
    Object? minFee = freezed,
    Object? distanceKm = freezed,
  }) {
    return _then(_$ClinicModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
                as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
                as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
                as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
                as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
                as double,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
                as bool,
      addedByDoctorId: freezed == addedByDoctorId
          ? _value.addedByDoctorId
          : addedByDoctorId // ignore: cast_nullable_to_non_nullable
                as String?,
      isNewClinic: null == isNewClinic
          ? _value.isNewClinic
          : isNewClinic // ignore: cast_nullable_to_non_nullable
                as bool,
      totalDoctors: freezed == totalDoctors
          ? _value.totalDoctors
          : totalDoctors // ignore: cast_nullable_to_non_nullable
                as int?,
      avgRating: freezed == avgRating
          ? _value.avgRating
          : avgRating // ignore: cast_nullable_to_non_nullable
                as double?,
      minFee: freezed == minFee
          ? _value.minFee
          : minFee // ignore: cast_nullable_to_non_nullable
                as double?,
      distanceKm: freezed == distanceKm
          ? _value.distanceKm
          : distanceKm // ignore: cast_nullable_to_non_nullable
                as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClinicModelImpl implements _ClinicModel {
  const _$ClinicModelImpl({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    this.isVerified = false,
    @JsonKey(name: 'added_by_doctor_id') this.addedByDoctorId,
    this.isNewClinic = false,
    this.totalDoctors,
    this.avgRating,
    this.minFee,
    this.distanceKm,
  });

  factory _$ClinicModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClinicModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final bool isVerified;
  @override
  @JsonKey(name: 'added_by_doctor_id')
  final String? addedByDoctorId;
  @override
  final bool isNewClinic;
  @override
  final int? totalDoctors;
  @override
  final double? avgRating;
  @override
  final double? minFee;
  @override
  final double? distanceKm;

  @override
  String toString() {
    return 'ClinicModel(id: $id, name: $name, address: $address, lat: $lat, lng: $lng, isVerified: $isVerified, addedByDoctorId: $addedByDoctorId, isNewClinic: $isNewClinic, totalDoctors: $totalDoctors, avgRating: $avgRating, minFee: $minFee, distanceKm: $distanceKm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.addedByDoctorId, addedByDoctorId) ||
                other.addedByDoctorId == addedByDoctorId) &&
            (identical(other.isNewClinic, isNewClinic) ||
                other.isNewClinic == isNewClinic) &&
            (identical(other.totalDoctors, totalDoctors) ||
                other.totalDoctors == totalDoctors) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating) &&
            (identical(other.minFee, minFee) || other.minFee == minFee) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
        runtimeType,
        id,
        name,
        address,
        lat,
        lng,
        isVerified,
        addedByDoctorId,
        isNewClinic,
        totalDoctors,
        avgRating,
        minFee,
        distanceKm,
      );

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicModelImplCopyWith<_$ClinicModelImpl> get copyWith =>
      __$$ClinicModelImplCopyWithImpl<_$ClinicModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClinicModelImplToJson(this);
  }
}

abstract class _ClinicModel implements ClinicModel {
  const factory _ClinicModel({
    required final String id,
    required final String name,
    required final String address,
    required final double lat,
    required final double lng,
    final bool isVerified,
    @JsonKey(name: 'added_by_doctor_id') final String? addedByDoctorId,
    final bool isNewClinic,
    final int? totalDoctors,
    final double? avgRating,
    final double? minFee,
    final double? distanceKm,
  }) = _$ClinicModelImpl;

  factory _ClinicModel.fromJson(Map<String, dynamic> json) =
      _$ClinicModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  double get lat;
  @override
  double get lng;
  @override
  bool get isVerified;
  @override
  @JsonKey(name: 'added_by_doctor_id')
  String? get addedByDoctorId;
  @override
  bool get isNewClinic;
  @override
  int? get totalDoctors;
  @override
  double? get avgRating;
  @override
  double? get minFee;
  @override
  double? get distanceKm;

  /// Create a copy of ClinicModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicModelImplCopyWith<_$ClinicModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
