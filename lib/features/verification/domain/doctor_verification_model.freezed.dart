// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_verification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DoctorVerificationModel _$DoctorVerificationModelFromJson(
  Map<String, dynamic> json,
) {
  return _DoctorVerificationModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorVerificationModel {
  String get id => throw _privateConstructorUsedError; // Doctor ID
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get specialization => throw _privateConstructorUsedError;
  @JsonKey(name: 'pmdc_number')
  String get pmdcNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_years')
  int? get experienceYears => throw _privateConstructorUsedError;
  @JsonKey(name: 'consultation_fee')
  double? get consultationFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_name')
  String? get clinicName => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_address')
  String? get clinicAddress => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason => throw _privateConstructorUsedError; // Document Fields (joined from doctor_verifications)
  @JsonKey(name: 'pmdc_license_url')
  String? get pmdcLicenseUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'degree_url')
  String? get degreeUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cnic_url')
  String? get cnicUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this DoctorVerificationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorVerificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorVerificationModelCopyWith<DoctorVerificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorVerificationModelCopyWith<$Res> {
  factory $DoctorVerificationModelCopyWith(
    DoctorVerificationModel value,
    $Res Function(DoctorVerificationModel) then,
  ) = _$DoctorVerificationModelCopyWithImpl<$Res, DoctorVerificationModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String? phone,
    String? specialization,
    @JsonKey(name: 'pmdc_number') String pmdcNumber,
    @JsonKey(name: 'experience_years') int? experienceYears,
    @JsonKey(name: 'consultation_fee') double? consultationFee,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
    String status,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'pmdc_license_url') String? pmdcLicenseUrl,
    @JsonKey(name: 'degree_url') String? degreeUrl,
    @JsonKey(name: 'cnic_url') String? cnicUrl,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$DoctorVerificationModelCopyWithImpl<
  $Res,
  $Val extends DoctorVerificationModel
>
    implements $DoctorVerificationModelCopyWith<$Res> {
  _$DoctorVerificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorVerificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? specialization = freezed,
    Object? pmdcNumber = null,
    Object? experienceYears = freezed,
    Object? consultationFee = freezed,
    Object? profileImageUrl = freezed,
    Object? clinicName = freezed,
    Object? clinicAddress = freezed,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? pmdcLicenseUrl = freezed,
    Object? degreeUrl = freezed,
    Object? cnicUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            specialization: freezed == specialization
                ? _value.specialization
                : specialization // ignore: cast_nullable_to_non_nullable
                      as String?,
            pmdcNumber: null == pmdcNumber
                ? _value.pmdcNumber
                : pmdcNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            experienceYears: freezed == experienceYears
                ? _value.experienceYears
                : experienceYears // ignore: cast_nullable_to_non_nullable
                      as int?,
            consultationFee: freezed == consultationFee
                ? _value.consultationFee
                : consultationFee // ignore: cast_nullable_to_non_nullable
                      as double?,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            clinicName: freezed == clinicName
                ? _value.clinicName
                : clinicName // ignore: cast_nullable_to_non_nullable
                      as String?,
            clinicAddress: freezed == clinicAddress
                ? _value.clinicAddress
                : clinicAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            rejectionReason: freezed == rejectionReason
                ? _value.rejectionReason
                : rejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            pmdcLicenseUrl: freezed == pmdcLicenseUrl
                ? _value.pmdcLicenseUrl
                : pmdcLicenseUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            degreeUrl: freezed == degreeUrl
                ? _value.degreeUrl
                : degreeUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            cnicUrl: freezed == cnicUrl
                ? _value.cnicUrl
                : cnicUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DoctorVerificationModelImplCopyWith<$Res>
    implements $DoctorVerificationModelCopyWith<$Res> {
  factory _$$DoctorVerificationModelImplCopyWith(
    _$DoctorVerificationModelImpl value,
    $Res Function(_$DoctorVerificationModelImpl) then,
  ) = __$$DoctorVerificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'full_name') String fullName,
    String email,
    String? phone,
    String? specialization,
    @JsonKey(name: 'pmdc_number') String pmdcNumber,
    @JsonKey(name: 'experience_years') int? experienceYears,
    @JsonKey(name: 'consultation_fee') double? consultationFee,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
    String status,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
    @JsonKey(name: 'pmdc_license_url') String? pmdcLicenseUrl,
    @JsonKey(name: 'degree_url') String? degreeUrl,
    @JsonKey(name: 'cnic_url') String? cnicUrl,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$DoctorVerificationModelImplCopyWithImpl<$Res>
    extends
        _$DoctorVerificationModelCopyWithImpl<
          $Res,
          _$DoctorVerificationModelImpl
        >
    implements _$$DoctorVerificationModelImplCopyWith<$Res> {
  __$$DoctorVerificationModelImplCopyWithImpl(
    _$DoctorVerificationModelImpl _value,
    $Res Function(_$DoctorVerificationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorVerificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? fullName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? specialization = freezed,
    Object? pmdcNumber = null,
    Object? experienceYears = freezed,
    Object? consultationFee = freezed,
    Object? profileImageUrl = freezed,
    Object? clinicName = freezed,
    Object? clinicAddress = freezed,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? pmdcLicenseUrl = freezed,
    Object? degreeUrl = freezed,
    Object? cnicUrl = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$DoctorVerificationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        specialization: freezed == specialization
            ? _value.specialization
            : specialization // ignore: cast_nullable_to_non_nullable
                  as String?,
        pmdcNumber: null == pmdcNumber
            ? _value.pmdcNumber
            : pmdcNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        experienceYears: freezed == experienceYears
            ? _value.experienceYears
            : experienceYears // ignore: cast_nullable_to_non_nullable
                  as int?,
        consultationFee: freezed == consultationFee
            ? _value.consultationFee
            : consultationFee // ignore: cast_nullable_to_non_nullable
                  as double?,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        clinicName: freezed == clinicName
            ? _value.clinicName
            : clinicName // ignore: cast_nullable_to_non_nullable
                  as String?,
        clinicAddress: freezed == clinicAddress
            ? _value.clinicAddress
            : clinicAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        rejectionReason: freezed == rejectionReason
            ? _value.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        pmdcLicenseUrl: freezed == pmdcLicenseUrl
            ? _value.pmdcLicenseUrl
            : pmdcLicenseUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        degreeUrl: freezed == degreeUrl
            ? _value.degreeUrl
            : degreeUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        cnicUrl: freezed == cnicUrl
            ? _value.cnicUrl
            : cnicUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorVerificationModelImpl implements _DoctorVerificationModel {
  const _$DoctorVerificationModelImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'full_name') required this.fullName,
    required this.email,
    this.phone,
    this.specialization,
    @JsonKey(name: 'pmdc_number') required this.pmdcNumber,
    @JsonKey(name: 'experience_years') this.experienceYears,
    @JsonKey(name: 'consultation_fee') this.consultationFee,
    @JsonKey(name: 'profile_image_url') this.profileImageUrl,
    @JsonKey(name: 'clinic_name') this.clinicName,
    @JsonKey(name: 'clinic_address') this.clinicAddress,
    this.status = 'pending',
    @JsonKey(name: 'rejection_reason') this.rejectionReason,
    @JsonKey(name: 'pmdc_license_url') this.pmdcLicenseUrl,
    @JsonKey(name: 'degree_url') this.degreeUrl,
    @JsonKey(name: 'cnic_url') this.cnicUrl,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$DoctorVerificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorVerificationModelImplFromJson(json);

  @override
  final String id;
  // Doctor ID
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String email;
  @override
  final String? phone;
  @override
  final String? specialization;
  @override
  @JsonKey(name: 'pmdc_number')
  final String pmdcNumber;
  @override
  @JsonKey(name: 'experience_years')
  final int? experienceYears;
  @override
  @JsonKey(name: 'consultation_fee')
  final double? consultationFee;
  @override
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  @override
  @JsonKey(name: 'clinic_name')
  final String? clinicName;
  @override
  @JsonKey(name: 'clinic_address')
  final String? clinicAddress;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;
  // Document Fields (joined from doctor_verifications)
  @override
  @JsonKey(name: 'pmdc_license_url')
  final String? pmdcLicenseUrl;
  @override
  @JsonKey(name: 'degree_url')
  final String? degreeUrl;
  @override
  @JsonKey(name: 'cnic_url')
  final String? cnicUrl;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'DoctorVerificationModel(id: $id, userId: $userId, fullName: $fullName, email: $email, phone: $phone, specialization: $specialization, pmdcNumber: $pmdcNumber, experienceYears: $experienceYears, consultationFee: $consultationFee, profileImageUrl: $profileImageUrl, clinicName: $clinicName, clinicAddress: $clinicAddress, status: $status, rejectionReason: $rejectionReason, pmdcLicenseUrl: $pmdcLicenseUrl, degreeUrl: $degreeUrl, cnicUrl: $cnicUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorVerificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.specialization, specialization) ||
                other.specialization == specialization) &&
            (identical(other.pmdcNumber, pmdcNumber) ||
                other.pmdcNumber == pmdcNumber) &&
            (identical(other.experienceYears, experienceYears) ||
                other.experienceYears == experienceYears) &&
            (identical(other.consultationFee, consultationFee) ||
                other.consultationFee == consultationFee) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName) &&
            (identical(other.clinicAddress, clinicAddress) ||
                other.clinicAddress == clinicAddress) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.pmdcLicenseUrl, pmdcLicenseUrl) ||
                other.pmdcLicenseUrl == pmdcLicenseUrl) &&
            (identical(other.degreeUrl, degreeUrl) ||
                other.degreeUrl == degreeUrl) &&
            (identical(other.cnicUrl, cnicUrl) || other.cnicUrl == cnicUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    fullName,
    email,
    phone,
    specialization,
    pmdcNumber,
    experienceYears,
    consultationFee,
    profileImageUrl,
    clinicName,
    clinicAddress,
    status,
    rejectionReason,
    pmdcLicenseUrl,
    degreeUrl,
    cnicUrl,
    createdAt,
  );

  /// Create a copy of DoctorVerificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorVerificationModelImplCopyWith<_$DoctorVerificationModelImpl>
  get copyWith =>
      __$$DoctorVerificationModelImplCopyWithImpl<
        _$DoctorVerificationModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorVerificationModelImplToJson(this);
  }
}

abstract class _DoctorVerificationModel implements DoctorVerificationModel {
  const factory _DoctorVerificationModel({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'full_name') required final String fullName,
    required final String email,
    final String? phone,
    final String? specialization,
    @JsonKey(name: 'pmdc_number') required final String pmdcNumber,
    @JsonKey(name: 'experience_years') final int? experienceYears,
    @JsonKey(name: 'consultation_fee') final double? consultationFee,
    @JsonKey(name: 'profile_image_url') final String? profileImageUrl,
    @JsonKey(name: 'clinic_name') final String? clinicName,
    @JsonKey(name: 'clinic_address') final String? clinicAddress,
    final String status,
    @JsonKey(name: 'rejection_reason') final String? rejectionReason,
    @JsonKey(name: 'pmdc_license_url') final String? pmdcLicenseUrl,
    @JsonKey(name: 'degree_url') final String? degreeUrl,
    @JsonKey(name: 'cnic_url') final String? cnicUrl,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$DoctorVerificationModelImpl;

  factory _DoctorVerificationModel.fromJson(Map<String, dynamic> json) =
      _$DoctorVerificationModelImpl.fromJson;

  @override
  String get id; // Doctor ID
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get email;
  @override
  String? get phone;
  @override
  String? get specialization;
  @override
  @JsonKey(name: 'pmdc_number')
  String get pmdcNumber;
  @override
  @JsonKey(name: 'experience_years')
  int? get experienceYears;
  @override
  @JsonKey(name: 'consultation_fee')
  double? get consultationFee;
  @override
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl;
  @override
  @JsonKey(name: 'clinic_name')
  String? get clinicName;
  @override
  @JsonKey(name: 'clinic_address')
  String? get clinicAddress;
  @override
  String get status;
  @override
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason; // Document Fields (joined from doctor_verifications)
  @override
  @JsonKey(name: 'pmdc_license_url')
  String? get pmdcLicenseUrl;
  @override
  @JsonKey(name: 'degree_url')
  String? get degreeUrl;
  @override
  @JsonKey(name: 'cnic_url')
  String? get cnicUrl;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of DoctorVerificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorVerificationModelImplCopyWith<_$DoctorVerificationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
