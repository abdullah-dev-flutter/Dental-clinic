// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upcoming_appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UpcomingAppointmentModel _$UpcomingAppointmentModelFromJson(
  Map<String, dynamic> json,
) {
  return _UpcomingAppointmentModel.fromJson(json);
}

/// @nodoc
mixin _$UpcomingAppointmentModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_id')
  String get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'appointment_date')
  DateTime get appointmentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String get endTime => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // Joined fields from view
  @JsonKey(name: 'doctor_id')
  String? get doctorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_name')
  String? get doctorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_avatar')
  String? get doctorAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_specialty')
  String? get doctorSpecialty => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_id')
  String? get serviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_name')
  String? get serviceName => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_icon')
  String? get serviceIcon => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_price')
  double? get servicePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_id')
  String? get clinicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_name')
  String? get clinicName => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_address')
  String? get clinicAddress => throw _privateConstructorUsedError;

  /// Serializes this UpcomingAppointmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpcomingAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpcomingAppointmentModelCopyWith<UpcomingAppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpcomingAppointmentModelCopyWith<$Res> {
  factory $UpcomingAppointmentModelCopyWith(
    UpcomingAppointmentModel value,
    $Res Function(UpcomingAppointmentModel) then,
  ) = _$UpcomingAppointmentModelCopyWithImpl<$Res, UpcomingAppointmentModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'patient_id') String patientId,
    @JsonKey(name: 'appointment_date') DateTime appointmentDate,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    String status,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'doctor_avatar') String? doctorAvatar,
    @JsonKey(name: 'doctor_specialty') String? doctorSpecialty,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'service_icon') String? serviceIcon,
    @JsonKey(name: 'service_price') double? servicePrice,
    @JsonKey(name: 'clinic_id') String? clinicId,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
  });
}

/// @nodoc
class _$UpcomingAppointmentModelCopyWithImpl<
  $Res,
  $Val extends UpcomingAppointmentModel
>
    implements $UpcomingAppointmentModelCopyWith<$Res> {
  _$UpcomingAppointmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpcomingAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? appointmentDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? doctorId = freezed,
    Object? doctorName = freezed,
    Object? doctorAvatar = freezed,
    Object? doctorSpecialty = freezed,
    Object? serviceId = freezed,
    Object? serviceName = freezed,
    Object? serviceIcon = freezed,
    Object? servicePrice = freezed,
    Object? clinicId = freezed,
    Object? clinicName = freezed,
    Object? clinicAddress = freezed,
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
            appointmentDate: null == appointmentDate
                ? _value.appointmentDate
                : appointmentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            doctorId: freezed == doctorId
                ? _value.doctorId
                : doctorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            doctorName: freezed == doctorName
                ? _value.doctorName
                : doctorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            doctorAvatar: freezed == doctorAvatar
                ? _value.doctorAvatar
                : doctorAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            doctorSpecialty: freezed == doctorSpecialty
                ? _value.doctorSpecialty
                : doctorSpecialty // ignore: cast_nullable_to_non_nullable
                      as String?,
            serviceId: freezed == serviceId
                ? _value.serviceId
                : serviceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            serviceName: freezed == serviceName
                ? _value.serviceName
                : serviceName // ignore: cast_nullable_to_non_nullable
                      as String?,
            serviceIcon: freezed == serviceIcon
                ? _value.serviceIcon
                : serviceIcon // ignore: cast_nullable_to_non_nullable
                      as String?,
            servicePrice: freezed == servicePrice
                ? _value.servicePrice
                : servicePrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            clinicId: freezed == clinicId
                ? _value.clinicId
                : clinicId // ignore: cast_nullable_to_non_nullable
                      as String?,
            clinicName: freezed == clinicName
                ? _value.clinicName
                : clinicName // ignore: cast_nullable_to_non_nullable
                      as String?,
            clinicAddress: freezed == clinicAddress
                ? _value.clinicAddress
                : clinicAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpcomingAppointmentModelImplCopyWith<$Res>
    implements $UpcomingAppointmentModelCopyWith<$Res> {
  factory _$$UpcomingAppointmentModelImplCopyWith(
    _$UpcomingAppointmentModelImpl value,
    $Res Function(_$UpcomingAppointmentModelImpl) then,
  ) = __$$UpcomingAppointmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'patient_id') String patientId,
    @JsonKey(name: 'appointment_date') DateTime appointmentDate,
    @JsonKey(name: 'start_time') String startTime,
    @JsonKey(name: 'end_time') String endTime,
    String status,
    @JsonKey(name: 'doctor_id') String? doctorId,
    @JsonKey(name: 'doctor_name') String? doctorName,
    @JsonKey(name: 'doctor_avatar') String? doctorAvatar,
    @JsonKey(name: 'doctor_specialty') String? doctorSpecialty,
    @JsonKey(name: 'service_id') String? serviceId,
    @JsonKey(name: 'service_name') String? serviceName,
    @JsonKey(name: 'service_icon') String? serviceIcon,
    @JsonKey(name: 'service_price') double? servicePrice,
    @JsonKey(name: 'clinic_id') String? clinicId,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
  });
}

/// @nodoc
class __$$UpcomingAppointmentModelImplCopyWithImpl<$Res>
    extends
        _$UpcomingAppointmentModelCopyWithImpl<
          $Res,
          _$UpcomingAppointmentModelImpl
        >
    implements _$$UpcomingAppointmentModelImplCopyWith<$Res> {
  __$$UpcomingAppointmentModelImplCopyWithImpl(
    _$UpcomingAppointmentModelImpl _value,
    $Res Function(_$UpcomingAppointmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UpcomingAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? appointmentDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? doctorId = freezed,
    Object? doctorName = freezed,
    Object? doctorAvatar = freezed,
    Object? doctorSpecialty = freezed,
    Object? serviceId = freezed,
    Object? serviceName = freezed,
    Object? serviceIcon = freezed,
    Object? servicePrice = freezed,
    Object? clinicId = freezed,
    Object? clinicName = freezed,
    Object? clinicAddress = freezed,
  }) {
    return _then(
      _$UpcomingAppointmentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentDate: null == appointmentDate
            ? _value.appointmentDate
            : appointmentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        doctorId: freezed == doctorId
            ? _value.doctorId
            : doctorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        doctorName: freezed == doctorName
            ? _value.doctorName
            : doctorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        doctorAvatar: freezed == doctorAvatar
            ? _value.doctorAvatar
            : doctorAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        doctorSpecialty: freezed == doctorSpecialty
            ? _value.doctorSpecialty
            : doctorSpecialty // ignore: cast_nullable_to_non_nullable
                  as String?,
        serviceId: freezed == serviceId
            ? _value.serviceId
            : serviceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        serviceName: freezed == serviceName
            ? _value.serviceName
            : serviceName // ignore: cast_nullable_to_non_nullable
                  as String?,
        serviceIcon: freezed == serviceIcon
            ? _value.serviceIcon
            : serviceIcon // ignore: cast_nullable_to_non_nullable
                  as String?,
        servicePrice: freezed == servicePrice
            ? _value.servicePrice
            : servicePrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        clinicId: freezed == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String?,
        clinicName: freezed == clinicName
            ? _value.clinicName
            : clinicName // ignore: cast_nullable_to_non_nullable
                  as String?,
        clinicAddress: freezed == clinicAddress
            ? _value.clinicAddress
            : clinicAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpcomingAppointmentModelImpl extends _UpcomingAppointmentModel {
  const _$UpcomingAppointmentModelImpl({
    required this.id,
    @JsonKey(name: 'patient_id') required this.patientId,
    @JsonKey(name: 'appointment_date') required this.appointmentDate,
    @JsonKey(name: 'start_time') required this.startTime,
    @JsonKey(name: 'end_time') required this.endTime,
    required this.status,
    @JsonKey(name: 'doctor_id') this.doctorId,
    @JsonKey(name: 'doctor_name') this.doctorName,
    @JsonKey(name: 'doctor_avatar') this.doctorAvatar,
    @JsonKey(name: 'doctor_specialty') this.doctorSpecialty,
    @JsonKey(name: 'service_id') this.serviceId,
    @JsonKey(name: 'service_name') this.serviceName,
    @JsonKey(name: 'service_icon') this.serviceIcon,
    @JsonKey(name: 'service_price') this.servicePrice,
    @JsonKey(name: 'clinic_id') this.clinicId,
    @JsonKey(name: 'clinic_name') this.clinicName,
    @JsonKey(name: 'clinic_address') this.clinicAddress,
  }) : super._();

  factory _$UpcomingAppointmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpcomingAppointmentModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'patient_id')
  final String patientId;
  @override
  @JsonKey(name: 'appointment_date')
  final DateTime appointmentDate;
  @override
  @JsonKey(name: 'start_time')
  final String startTime;
  @override
  @JsonKey(name: 'end_time')
  final String endTime;
  @override
  final String status;
  // Joined fields from view
  @override
  @JsonKey(name: 'doctor_id')
  final String? doctorId;
  @override
  @JsonKey(name: 'doctor_name')
  final String? doctorName;
  @override
  @JsonKey(name: 'doctor_avatar')
  final String? doctorAvatar;
  @override
  @JsonKey(name: 'doctor_specialty')
  final String? doctorSpecialty;
  @override
  @JsonKey(name: 'service_id')
  final String? serviceId;
  @override
  @JsonKey(name: 'service_name')
  final String? serviceName;
  @override
  @JsonKey(name: 'service_icon')
  final String? serviceIcon;
  @override
  @JsonKey(name: 'service_price')
  final double? servicePrice;
  @override
  @JsonKey(name: 'clinic_id')
  final String? clinicId;
  @override
  @JsonKey(name: 'clinic_name')
  final String? clinicName;
  @override
  @JsonKey(name: 'clinic_address')
  final String? clinicAddress;

  @override
  String toString() {
    return 'UpcomingAppointmentModel(id: $id, patientId: $patientId, appointmentDate: $appointmentDate, startTime: $startTime, endTime: $endTime, status: $status, doctorId: $doctorId, doctorName: $doctorName, doctorAvatar: $doctorAvatar, doctorSpecialty: $doctorSpecialty, serviceId: $serviceId, serviceName: $serviceName, serviceIcon: $serviceIcon, servicePrice: $servicePrice, clinicId: $clinicId, clinicName: $clinicName, clinicAddress: $clinicAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpcomingAppointmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.appointmentDate, appointmentDate) ||
                other.appointmentDate == appointmentDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.doctorAvatar, doctorAvatar) ||
                other.doctorAvatar == doctorAvatar) &&
            (identical(other.doctorSpecialty, doctorSpecialty) ||
                other.doctorSpecialty == doctorSpecialty) &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.serviceIcon, serviceIcon) ||
                other.serviceIcon == serviceIcon) &&
            (identical(other.servicePrice, servicePrice) ||
                other.servicePrice == servicePrice) &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName) &&
            (identical(other.clinicAddress, clinicAddress) ||
                other.clinicAddress == clinicAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patientId,
    appointmentDate,
    startTime,
    endTime,
    status,
    doctorId,
    doctorName,
    doctorAvatar,
    doctorSpecialty,
    serviceId,
    serviceName,
    serviceIcon,
    servicePrice,
    clinicId,
    clinicName,
    clinicAddress,
  );

  /// Create a copy of UpcomingAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpcomingAppointmentModelImplCopyWith<_$UpcomingAppointmentModelImpl>
  get copyWith =>
      __$$UpcomingAppointmentModelImplCopyWithImpl<
        _$UpcomingAppointmentModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpcomingAppointmentModelImplToJson(this);
  }
}

abstract class _UpcomingAppointmentModel extends UpcomingAppointmentModel {
  const factory _UpcomingAppointmentModel({
    required final String id,
    @JsonKey(name: 'patient_id') required final String patientId,
    @JsonKey(name: 'appointment_date') required final DateTime appointmentDate,
    @JsonKey(name: 'start_time') required final String startTime,
    @JsonKey(name: 'end_time') required final String endTime,
    required final String status,
    @JsonKey(name: 'doctor_id') final String? doctorId,
    @JsonKey(name: 'doctor_name') final String? doctorName,
    @JsonKey(name: 'doctor_avatar') final String? doctorAvatar,
    @JsonKey(name: 'doctor_specialty') final String? doctorSpecialty,
    @JsonKey(name: 'service_id') final String? serviceId,
    @JsonKey(name: 'service_name') final String? serviceName,
    @JsonKey(name: 'service_icon') final String? serviceIcon,
    @JsonKey(name: 'service_price') final double? servicePrice,
    @JsonKey(name: 'clinic_id') final String? clinicId,
    @JsonKey(name: 'clinic_name') final String? clinicName,
    @JsonKey(name: 'clinic_address') final String? clinicAddress,
  }) = _$UpcomingAppointmentModelImpl;
  const _UpcomingAppointmentModel._() : super._();

  factory _UpcomingAppointmentModel.fromJson(Map<String, dynamic> json) =
      _$UpcomingAppointmentModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'patient_id')
  String get patientId;
  @override
  @JsonKey(name: 'appointment_date')
  DateTime get appointmentDate;
  @override
  @JsonKey(name: 'start_time')
  String get startTime;
  @override
  @JsonKey(name: 'end_time')
  String get endTime;
  @override
  String get status; // Joined fields from view
  @override
  @JsonKey(name: 'doctor_id')
  String? get doctorId;
  @override
  @JsonKey(name: 'doctor_name')
  String? get doctorName;
  @override
  @JsonKey(name: 'doctor_avatar')
  String? get doctorAvatar;
  @override
  @JsonKey(name: 'doctor_specialty')
  String? get doctorSpecialty;
  @override
  @JsonKey(name: 'service_id')
  String? get serviceId;
  @override
  @JsonKey(name: 'service_name')
  String? get serviceName;
  @override
  @JsonKey(name: 'service_icon')
  String? get serviceIcon;
  @override
  @JsonKey(name: 'service_price')
  double? get servicePrice;
  @override
  @JsonKey(name: 'clinic_id')
  String? get clinicId;
  @override
  @JsonKey(name: 'clinic_name')
  String? get clinicName;
  @override
  @JsonKey(name: 'clinic_address')
  String? get clinicAddress;

  /// Create a copy of UpcomingAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpcomingAppointmentModelImplCopyWith<_$UpcomingAppointmentModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
