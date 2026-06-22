// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) {
  return _DoctorModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorModel {
  String get id => throw _privateConstructorUsedError;
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
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_name')
  String? get clinicName => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_address')
  String? get clinicAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_lat')
  double? get clinicLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'clinic_lng')
  double? get clinicLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_available')
  bool get isAvailable => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_reviews')
  int get totalReviews => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_patients')
  int get totalPatients => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason => throw _privateConstructorUsedError;

  /// Serializes this DoctorModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorModelCopyWith<DoctorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorModelCopyWith<$Res> {
  factory $DoctorModelCopyWith(
    DoctorModel value,
    $Res Function(DoctorModel) then,
  ) = _$DoctorModelCopyWithImpl<$Res, DoctorModel>;
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
    String? bio,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
    @JsonKey(name: 'clinic_lat') double? clinicLat,
    @JsonKey(name: 'clinic_lng') double? clinicLng,
    @JsonKey(name: 'is_available') bool isAvailable,
    double rating,
    @JsonKey(name: 'total_reviews') int totalReviews,
    @JsonKey(name: 'total_patients') int totalPatients,
    String status,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
  });
}

/// @nodoc
class _$DoctorModelCopyWithImpl<$Res, $Val extends DoctorModel>
    implements $DoctorModelCopyWith<$Res> {
  _$DoctorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorModel
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
    Object? bio = freezed,
    Object? profileImageUrl = freezed,
    Object? clinicName = freezed,
    Object? clinicAddress = freezed,
    Object? clinicLat = freezed,
    Object? clinicLng = freezed,
    Object? isAvailable = null,
    Object? rating = null,
    Object? totalReviews = null,
    Object? totalPatients = null,
    Object? status = null,
    Object? rejectionReason = freezed,
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
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            clinicLat: freezed == clinicLat
                ? _value.clinicLat
                : clinicLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            clinicLng: freezed == clinicLng
                ? _value.clinicLng
                : clinicLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            totalReviews: null == totalReviews
                ? _value.totalReviews
                : totalReviews // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPatients: null == totalPatients
                ? _value.totalPatients
                : totalPatients // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            rejectionReason: freezed == rejectionReason
                ? _value.rejectionReason
                : rejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DoctorModelImplCopyWith<$Res>
    implements $DoctorModelCopyWith<$Res> {
  factory _$$DoctorModelImplCopyWith(
    _$DoctorModelImpl value,
    $Res Function(_$DoctorModelImpl) then,
  ) = __$$DoctorModelImplCopyWithImpl<$Res>;
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
    String? bio,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'clinic_name') String? clinicName,
    @JsonKey(name: 'clinic_address') String? clinicAddress,
    @JsonKey(name: 'clinic_lat') double? clinicLat,
    @JsonKey(name: 'clinic_lng') double? clinicLng,
    @JsonKey(name: 'is_available') bool isAvailable,
    double rating,
    @JsonKey(name: 'total_reviews') int totalReviews,
    @JsonKey(name: 'total_patients') int totalPatients,
    String status,
    @JsonKey(name: 'rejection_reason') String? rejectionReason,
  });
}

/// @nodoc
class __$$DoctorModelImplCopyWithImpl<$Res>
    extends _$DoctorModelCopyWithImpl<$Res, _$DoctorModelImpl>
    implements _$$DoctorModelImplCopyWith<$Res> {
  __$$DoctorModelImplCopyWithImpl(
    _$DoctorModelImpl _value,
    $Res Function(_$DoctorModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorModel
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
    Object? bio = freezed,
    Object? profileImageUrl = freezed,
    Object? clinicName = freezed,
    Object? clinicAddress = freezed,
    Object? clinicLat = freezed,
    Object? clinicLng = freezed,
    Object? isAvailable = null,
    Object? rating = null,
    Object? totalReviews = null,
    Object? totalPatients = null,
    Object? status = null,
    Object? rejectionReason = freezed,
  }) {
    return _then(
      _$DoctorModelImpl(
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
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        clinicLat: freezed == clinicLat
            ? _value.clinicLat
            : clinicLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        clinicLng: freezed == clinicLng
            ? _value.clinicLng
            : clinicLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        totalReviews: null == totalReviews
            ? _value.totalReviews
            : totalReviews // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPatients: null == totalPatients
            ? _value.totalPatients
            : totalPatients // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        rejectionReason: freezed == rejectionReason
            ? _value.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorModelImpl implements _DoctorModel {
  const _$DoctorModelImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'full_name') required this.fullName,
    required this.email,
    this.phone,
    this.specialization,
    @JsonKey(name: 'pmdc_number') required this.pmdcNumber,
    @JsonKey(name: 'experience_years') this.experienceYears,
    @JsonKey(name: 'consultation_fee') this.consultationFee,
    this.bio,
    @JsonKey(name: 'profile_image_url') this.profileImageUrl,
    @JsonKey(name: 'clinic_name') this.clinicName,
    @JsonKey(name: 'clinic_address') this.clinicAddress,
    @JsonKey(name: 'clinic_lat') this.clinicLat,
    @JsonKey(name: 'clinic_lng') this.clinicLng,
    @JsonKey(name: 'is_available') this.isAvailable = true,
    this.rating = 0.0,
    @JsonKey(name: 'total_reviews') this.totalReviews = 0,
    @JsonKey(name: 'total_patients') this.totalPatients = 0,
    this.status = 'pending',
    @JsonKey(name: 'rejection_reason') this.rejectionReason,
  });

  factory _$DoctorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorModelImplFromJson(json);

  @override
  final String id;
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
  final String? bio;
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
  @JsonKey(name: 'clinic_lat')
  final double? clinicLat;
  @override
  @JsonKey(name: 'clinic_lng')
  final double? clinicLng;
  @override
  @JsonKey(name: 'is_available')
  final bool isAvailable;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'total_reviews')
  final int totalReviews;
  @override
  @JsonKey(name: 'total_patients')
  final int totalPatients;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;

  @override
  String toString() {
    return 'DoctorModel(id: $id, userId: $userId, fullName: $fullName, email: $email, phone: $phone, specialization: $specialization, pmdcNumber: $pmdcNumber, experienceYears: $experienceYears, consultationFee: $consultationFee, bio: $bio, profileImageUrl: $profileImageUrl, clinicName: $clinicName, clinicAddress: $clinicAddress, clinicLat: $clinicLat, clinicLng: $clinicLng, isAvailable: $isAvailable, rating: $rating, totalReviews: $totalReviews, totalPatients: $totalPatients, status: $status, rejectionReason: $rejectionReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorModelImpl &&
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
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.clinicName, clinicName) ||
                other.clinicName == clinicName) &&
            (identical(other.clinicAddress, clinicAddress) ||
                other.clinicAddress == clinicAddress) &&
            (identical(other.clinicLat, clinicLat) ||
                other.clinicLat == clinicLat) &&
            (identical(other.clinicLng, clinicLng) ||
                other.clinicLng == clinicLng) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            (identical(other.totalPatients, totalPatients) ||
                other.totalPatients == totalPatients) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
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
    bio,
    profileImageUrl,
    clinicName,
    clinicAddress,
    clinicLat,
    clinicLng,
    isAvailable,
    rating,
    totalReviews,
    totalPatients,
    status,
    rejectionReason,
  ]);

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      __$$DoctorModelImplCopyWithImpl<_$DoctorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorModelImplToJson(this);
  }
}

abstract class _DoctorModel implements DoctorModel {
  const factory _DoctorModel({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'full_name') required final String fullName,
    required final String email,
    final String? phone,
    final String? specialization,
    @JsonKey(name: 'pmdc_number') required final String pmdcNumber,
    @JsonKey(name: 'experience_years') final int? experienceYears,
    @JsonKey(name: 'consultation_fee') final double? consultationFee,
    final String? bio,
    @JsonKey(name: 'profile_image_url') final String? profileImageUrl,
    @JsonKey(name: 'clinic_name') final String? clinicName,
    @JsonKey(name: 'clinic_address') final String? clinicAddress,
    @JsonKey(name: 'clinic_lat') final double? clinicLat,
    @JsonKey(name: 'clinic_lng') final double? clinicLng,
    @JsonKey(name: 'is_available') final bool isAvailable,
    final double rating,
    @JsonKey(name: 'total_reviews') final int totalReviews,
    @JsonKey(name: 'total_patients') final int totalPatients,
    final String status,
    @JsonKey(name: 'rejection_reason') final String? rejectionReason,
  }) = _$DoctorModelImpl;

  factory _DoctorModel.fromJson(Map<String, dynamic> json) =
      _$DoctorModelImpl.fromJson;

  @override
  String get id;
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
  String? get bio;
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
  @JsonKey(name: 'clinic_lat')
  double? get clinicLat;
  @override
  @JsonKey(name: 'clinic_lng')
  double? get clinicLng;
  @override
  @JsonKey(name: 'is_available')
  bool get isAvailable;
  @override
  double get rating;
  @override
  @JsonKey(name: 'total_reviews')
  int get totalReviews;
  @override
  @JsonKey(name: 'total_patients')
  int get totalPatients;
  @override
  String get status;
  @override
  @JsonKey(name: 'rejection_reason')
  String? get rejectionReason;

  /// Create a copy of DoctorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorModelImplCopyWith<_$DoctorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
