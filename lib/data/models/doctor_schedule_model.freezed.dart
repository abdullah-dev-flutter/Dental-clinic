// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DoctorScheduleModel _$DoctorScheduleModelFromJson(Map<String, dynamic> json) {
  return _DoctorScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorScheduleModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_id')
  String get doctorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_of_week')
  String get dayOfWeek => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;

  /// Serializes this DoctorScheduleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorScheduleModelCopyWith<DoctorScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorScheduleModelCopyWith<$Res> {
  factory $DoctorScheduleModelCopyWith(
    DoctorScheduleModel value,
    $Res Function(DoctorScheduleModel) then,
  ) = _$DoctorScheduleModelCopyWithImpl<$Res, DoctorScheduleModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'doctor_id') String doctorId,
    @JsonKey(name: 'day_of_week') String dayOfWeek,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'is_available') bool isAvailable,
  });
}

/// @nodoc
class _$DoctorScheduleModelCopyWithImpl<$Res, $Val extends DoctorScheduleModel>
    implements $DoctorScheduleModelCopyWith<$Res> {
  _$DoctorScheduleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doctorId = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            doctorId: null == doctorId
                ? _value.doctorId
                : doctorId // ignore: cast_nullable_to_non_nullable
                      as String,
            dayOfWeek: null == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DoctorScheduleModelImplCopyWith<$Res>
    implements $DoctorScheduleModelCopyWith<$Res> {
  factory _$$DoctorScheduleModelImplCopyWith(
    _$DoctorScheduleModelImpl value,
    $Res Function(_$DoctorScheduleModelImpl) then,
  ) = __$$DoctorScheduleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'doctor_id') String doctorId,
    @JsonKey(name: 'day_of_week') String dayOfWeek,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    @JsonKey(name: 'is_available') bool isAvailable,
  });
}

/// @nodoc
class __$$DoctorScheduleModelImplCopyWithImpl<$Res>
    extends _$DoctorScheduleModelCopyWithImpl<$Res, _$DoctorScheduleModelImpl>
    implements _$$DoctorScheduleModelImplCopyWith<$Res> {
  __$$DoctorScheduleModelImplCopyWithImpl(
    _$DoctorScheduleModelImpl _value,
    $Res Function(_$DoctorScheduleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? doctorId = null,
    Object? dayOfWeek = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? isAvailable = null,
  }) {
    return _then(
      _$DoctorScheduleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        doctorId: null == doctorId
            ? _value.doctorId
            : doctorId // ignore: cast_nullable_to_non_nullable
                  as String,
        dayOfWeek: null == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorScheduleModelImpl implements _DoctorScheduleModel {
  const _$DoctorScheduleModelImpl({
    required this.id,
    @JsonKey(name: 'doctor_id') required this.doctorId,
    @JsonKey(name: 'day_of_week') required this.dayOfWeek,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    @JsonKey(name: 'is_available') this.isAvailable = true,
  });

  factory _$DoctorScheduleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorScheduleModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'doctor_id')
  final String doctorId;
  @override
  @JsonKey(name: 'day_of_week')
  final String dayOfWeek;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;
  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;

  @override
  String toString() {
    return 'DoctorScheduleModel(id: $id, doctorId: $doctorId, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorScheduleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    doctorId,
    dayOfWeek,
    startTime,
    endTime,
    isAvailable,
  );

  /// Create a copy of DoctorScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorScheduleModelImplCopyWith<_$DoctorScheduleModelImpl> get copyWith =>
      __$$DoctorScheduleModelImplCopyWithImpl<_$DoctorScheduleModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorScheduleModelImplToJson(this);
  }
}

abstract class _DoctorScheduleModel implements DoctorScheduleModel {
  const factory _DoctorScheduleModel({
    required final String id,
    @JsonKey(name: 'doctor_id') required final String doctorId,
    @JsonKey(name: 'day_of_week') required final String dayOfWeek,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    @JsonKey(name: 'is_available') final bool isAvailable,
  }) = _$DoctorScheduleModelImpl;

  factory _DoctorScheduleModel.fromJson(Map<String, dynamic> json) =
      _$DoctorScheduleModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'doctor_id')
  String get doctorId;
  @override
  @JsonKey(name: 'day_of_week')
  String get dayOfWeek;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;

  /// Create a copy of DoctorScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorScheduleModelImplCopyWith<_$DoctorScheduleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
