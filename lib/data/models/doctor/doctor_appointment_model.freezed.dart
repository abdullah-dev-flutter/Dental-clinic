// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DoctorAppointmentModel _$DoctorAppointmentModelFromJson(
  Map<String, dynamic> json,
) {
  return _DoctorAppointmentModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorAppointmentModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_id')
  String get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'doctor_id')
  String get doctorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'appointment_date')
  DateTime get appointmentDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'appointment_time')
  String get appointmentTime => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get symptoms => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get prescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  double? get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_status')
  String get paymentStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_id')
  String? get paymentId => throw _privateConstructorUsedError;
  ProfileModel? get patient => throw _privateConstructorUsedError;

  /// Serializes this DoctorAppointmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorAppointmentModelCopyWith<DoctorAppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorAppointmentModelCopyWith<$Res> {
  factory $DoctorAppointmentModelCopyWith(
    DoctorAppointmentModel value,
    $Res Function(DoctorAppointmentModel) then,
  ) = _$DoctorAppointmentModelCopyWithImpl<$Res, DoctorAppointmentModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'patient_id') String patientId,
    @JsonKey(name: 'doctor_id') String doctorId,
    @JsonKey(name: 'appointment_date') DateTime appointmentDate,
    @JsonKey(name: 'appointment_time') String appointmentTime,
    int duration,
    String status,
    String type,
    String? symptoms,
    String? notes,
    String? prescription,
    @JsonKey(name: 'total_amount') double? totalAmount,
    @JsonKey(name: 'payment_status') String paymentStatus,
    @JsonKey(name: 'payment_id') String? paymentId,
    ProfileModel? patient,
  });

  $ProfileModelCopyWith<$Res>? get patient;
}

/// @nodoc
class _$DoctorAppointmentModelCopyWithImpl<
  $Res,
  $Val extends DoctorAppointmentModel
>
    implements $DoctorAppointmentModelCopyWith<$Res> {
  _$DoctorAppointmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? doctorId = null,
    Object? appointmentDate = null,
    Object? appointmentTime = null,
    Object? duration = null,
    Object? status = null,
    Object? type = null,
    Object? symptoms = freezed,
    Object? notes = freezed,
    Object? prescription = freezed,
    Object? totalAmount = freezed,
    Object? paymentStatus = null,
    Object? paymentId = freezed,
    Object? patient = freezed,
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
            doctorId: null == doctorId
                ? _value.doctorId
                : doctorId // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentDate: null == appointmentDate
                ? _value.appointmentDate
                : appointmentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            appointmentTime: null == appointmentTime
                ? _value.appointmentTime
                : appointmentTime // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            symptoms: freezed == symptoms
                ? _value.symptoms
                : symptoms // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            prescription: freezed == prescription
                ? _value.prescription
                : prescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalAmount: freezed == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            paymentStatus: null == paymentStatus
                ? _value.paymentStatus
                : paymentStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentId: freezed == paymentId
                ? _value.paymentId
                : paymentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            patient: freezed == patient
                ? _value.patient
                : patient // ignore: cast_nullable_to_non_nullable
                      as ProfileModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of DoctorAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileModelCopyWith<$Res>? get patient {
    if (_value.patient == null) {
      return null;
    }

    return $ProfileModelCopyWith<$Res>(_value.patient!, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DoctorAppointmentModelImplCopyWith<$Res>
    implements $DoctorAppointmentModelCopyWith<$Res> {
  factory _$$DoctorAppointmentModelImplCopyWith(
    _$DoctorAppointmentModelImpl value,
    $Res Function(_$DoctorAppointmentModelImpl) then,
  ) = __$$DoctorAppointmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'patient_id') String patientId,
    @JsonKey(name: 'doctor_id') String doctorId,
    @JsonKey(name: 'appointment_date') DateTime appointmentDate,
    @JsonKey(name: 'appointment_time') String appointmentTime,
    int duration,
    String status,
    String type,
    String? symptoms,
    String? notes,
    String? prescription,
    @JsonKey(name: 'total_amount') double? totalAmount,
    @JsonKey(name: 'payment_status') String paymentStatus,
    @JsonKey(name: 'payment_id') String? paymentId,
    ProfileModel? patient,
  });

  @override
  $ProfileModelCopyWith<$Res>? get patient;
}

/// @nodoc
class __$$DoctorAppointmentModelImplCopyWithImpl<$Res>
    extends
        _$DoctorAppointmentModelCopyWithImpl<$Res, _$DoctorAppointmentModelImpl>
    implements _$$DoctorAppointmentModelImplCopyWith<$Res> {
  __$$DoctorAppointmentModelImplCopyWithImpl(
    _$DoctorAppointmentModelImpl _value,
    $Res Function(_$DoctorAppointmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientId = null,
    Object? doctorId = null,
    Object? appointmentDate = null,
    Object? appointmentTime = null,
    Object? duration = null,
    Object? status = null,
    Object? type = null,
    Object? symptoms = freezed,
    Object? notes = freezed,
    Object? prescription = freezed,
    Object? totalAmount = freezed,
    Object? paymentStatus = null,
    Object? paymentId = freezed,
    Object? patient = freezed,
  }) {
    return _then(
      _$DoctorAppointmentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientId: null == patientId
            ? _value.patientId
            : patientId // ignore: cast_nullable_to_non_nullable
                  as String,
        doctorId: null == doctorId
            ? _value.doctorId
            : doctorId // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentDate: null == appointmentDate
            ? _value.appointmentDate
            : appointmentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        appointmentTime: null == appointmentTime
            ? _value.appointmentTime
            : appointmentTime // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        symptoms: freezed == symptoms
            ? _value.symptoms
            : symptoms // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        prescription: freezed == prescription
            ? _value.prescription
            : prescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalAmount: freezed == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        paymentStatus: null == paymentStatus
            ? _value.paymentStatus
            : paymentStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentId: freezed == paymentId
            ? _value.paymentId
            : paymentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        patient: freezed == patient
            ? _value.patient
            : patient // ignore: cast_nullable_to_non_nullable
                  as ProfileModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorAppointmentModelImpl implements _DoctorAppointmentModel {
  const _$DoctorAppointmentModelImpl({
    required this.id,
    @JsonKey(name: 'patient_id') required this.patientId,
    @JsonKey(name: 'doctor_id') required this.doctorId,
    @JsonKey(name: 'appointment_date') required this.appointmentDate,
    @JsonKey(name: 'appointment_time') required this.appointmentTime,
    this.duration = 30,
    this.status = 'pending',
    this.type = 'consultation',
    this.symptoms,
    this.notes,
    this.prescription,
    @JsonKey(name: 'total_amount') this.totalAmount,
    @JsonKey(name: 'payment_status') this.paymentStatus = 'unpaid',
    @JsonKey(name: 'payment_id') this.paymentId,
    this.patient,
  });

  factory _$DoctorAppointmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorAppointmentModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'patient_id')
  final String patientId;
  @override
  @JsonKey(name: 'doctor_id')
  final String doctorId;
  @override
  @JsonKey(name: 'appointment_date')
  final DateTime appointmentDate;
  @override
  @JsonKey(name: 'appointment_time')
  final String appointmentTime;
  @override
  @JsonKey()
  final int duration;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String type;
  @override
  final String? symptoms;
  @override
  final String? notes;
  @override
  final String? prescription;
  @override
  @JsonKey(name: 'total_amount')
  final double? totalAmount;
  @override
  @JsonKey(name: 'payment_status')
  final String paymentStatus;
  @override
  @JsonKey(name: 'payment_id')
  final String? paymentId;
  @override
  final ProfileModel? patient;

  @override
  String toString() {
    return 'DoctorAppointmentModel(id: $id, patientId: $patientId, doctorId: $doctorId, appointmentDate: $appointmentDate, appointmentTime: $appointmentTime, duration: $duration, status: $status, type: $type, symptoms: $symptoms, notes: $notes, prescription: $prescription, totalAmount: $totalAmount, paymentStatus: $paymentStatus, paymentId: $paymentId, patient: $patient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorAppointmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.doctorId, doctorId) ||
                other.doctorId == doctorId) &&
            (identical(other.appointmentDate, appointmentDate) ||
                other.appointmentDate == appointmentDate) &&
            (identical(other.appointmentTime, appointmentTime) ||
                other.appointmentTime == appointmentTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.symptoms, symptoms) ||
                other.symptoms == symptoms) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.prescription, prescription) ||
                other.prescription == prescription) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.patient, patient) || other.patient == patient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patientId,
    doctorId,
    appointmentDate,
    appointmentTime,
    duration,
    status,
    type,
    symptoms,
    notes,
    prescription,
    totalAmount,
    paymentStatus,
    paymentId,
    patient,
  );

  /// Create a copy of DoctorAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorAppointmentModelImplCopyWith<_$DoctorAppointmentModelImpl>
  get copyWith =>
      __$$DoctorAppointmentModelImplCopyWithImpl<_$DoctorAppointmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorAppointmentModelImplToJson(this);
  }
}

abstract class _DoctorAppointmentModel implements DoctorAppointmentModel {
  const factory _DoctorAppointmentModel({
    required final String id,
    @JsonKey(name: 'patient_id') required final String patientId,
    @JsonKey(name: 'doctor_id') required final String doctorId,
    @JsonKey(name: 'appointment_date') required final DateTime appointmentDate,
    @JsonKey(name: 'appointment_time') required final String appointmentTime,
    final int duration,
    final String status,
    final String type,
    final String? symptoms,
    final String? notes,
    final String? prescription,
    @JsonKey(name: 'total_amount') final double? totalAmount,
    @JsonKey(name: 'payment_status') final String paymentStatus,
    @JsonKey(name: 'payment_id') final String? paymentId,
    final ProfileModel? patient,
  }) = _$DoctorAppointmentModelImpl;

  factory _DoctorAppointmentModel.fromJson(Map<String, dynamic> json) =
      _$DoctorAppointmentModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'patient_id')
  String get patientId;
  @override
  @JsonKey(name: 'doctor_id')
  String get doctorId;
  @override
  @JsonKey(name: 'appointment_date')
  DateTime get appointmentDate;
  @override
  @JsonKey(name: 'appointment_time')
  String get appointmentTime;
  @override
  int get duration;
  @override
  String get status;
  @override
  String get type;
  @override
  String? get symptoms;
  @override
  String? get notes;
  @override
  String? get prescription;
  @override
  @JsonKey(name: 'total_amount')
  double? get totalAmount;
  @override
  @JsonKey(name: 'payment_status')
  String get paymentStatus;
  @override
  @JsonKey(name: 'payment_id')
  String? get paymentId;
  @override
  ProfileModel? get patient;

  /// Create a copy of DoctorAppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorAppointmentModelImplCopyWith<_$DoctorAppointmentModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
