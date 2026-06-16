// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_with_services_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DoctorWithServicesModel _$DoctorWithServicesModelFromJson(
  Map<String, dynamic> json,
) {
  return _DoctorWithServicesModel.fromJson(json);
}

/// @nodoc
mixin _$DoctorWithServicesModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;
  String get specialty => throw _privateConstructorUsedError;
  String? get qualification => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_count')
  int get reviewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_online')
  bool get isOnline => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_years')
  int get experienceYears => throw _privateConstructorUsedError;
  @JsonKey(name: 'consultation_fee')
  double get consultationFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_count')
  int get serviceCount => throw _privateConstructorUsedError;
  @JsonKey(
    name: 'service_ids',
    fromJson: _serviceIdsFromJson,
    toJson: _serviceIdsToJson,
  )
  List<String> get serviceIds => throw _privateConstructorUsedError;

  /// Serializes this DoctorWithServicesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DoctorWithServicesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorWithServicesModelCopyWith<DoctorWithServicesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorWithServicesModelCopyWith<$Res> {
  factory $DoctorWithServicesModelCopyWith(
    DoctorWithServicesModel value,
    $Res Function(DoctorWithServicesModel) then,
  ) = _$DoctorWithServicesModelCopyWithImpl<$Res, DoctorWithServicesModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String specialty,
    String? qualification,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    double rating,
    @JsonKey(name: 'review_count') int reviewCount,
    @JsonKey(name: 'is_online') bool isOnline,
    @JsonKey(name: 'experience_years') int experienceYears,
    @JsonKey(name: 'consultation_fee') double consultationFee,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'service_count') int serviceCount,
    @JsonKey(
      name: 'service_ids',
      fromJson: _serviceIdsFromJson,
      toJson: _serviceIdsToJson,
    )
    List<String> serviceIds,
  });
}

/// @nodoc
class _$DoctorWithServicesModelCopyWithImpl<
  $Res,
  $Val extends DoctorWithServicesModel
>
    implements $DoctorWithServicesModelCopyWith<$Res> {
  _$DoctorWithServicesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorWithServicesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? specialty = null,
    Object? qualification = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isOnline = null,
    Object? experienceYears = null,
    Object? consultationFee = null,
    Object? isActive = null,
    Object? serviceCount = null,
    Object? serviceIds = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            specialty: null == specialty
                ? _value.specialty
                : specialty // ignore: cast_nullable_to_non_nullable
                      as String,
            qualification: freezed == qualification
                ? _value.qualification
                : qualification // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isOnline: null == isOnline
                ? _value.isOnline
                : isOnline // ignore: cast_nullable_to_non_nullable
                      as bool,
            experienceYears: null == experienceYears
                ? _value.experienceYears
                : experienceYears // ignore: cast_nullable_to_non_nullable
                      as int,
            consultationFee: null == consultationFee
                ? _value.consultationFee
                : consultationFee // ignore: cast_nullable_to_non_nullable
                      as double,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            serviceCount: null == serviceCount
                ? _value.serviceCount
                : serviceCount // ignore: cast_nullable_to_non_nullable
                      as int,
            serviceIds: null == serviceIds
                ? _value.serviceIds
                : serviceIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DoctorWithServicesModelImplCopyWith<$Res>
    implements $DoctorWithServicesModelCopyWith<$Res> {
  factory _$$DoctorWithServicesModelImplCopyWith(
    _$DoctorWithServicesModelImpl value,
    $Res Function(_$DoctorWithServicesModelImpl) then,
  ) = __$$DoctorWithServicesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'full_name') String fullName,
    String specialty,
    String? qualification,
    String? bio,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    double rating,
    @JsonKey(name: 'review_count') int reviewCount,
    @JsonKey(name: 'is_online') bool isOnline,
    @JsonKey(name: 'experience_years') int experienceYears,
    @JsonKey(name: 'consultation_fee') double consultationFee,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'service_count') int serviceCount,
    @JsonKey(
      name: 'service_ids',
      fromJson: _serviceIdsFromJson,
      toJson: _serviceIdsToJson,
    )
    List<String> serviceIds,
  });
}

/// @nodoc
class __$$DoctorWithServicesModelImplCopyWithImpl<$Res>
    extends
        _$DoctorWithServicesModelCopyWithImpl<
          $Res,
          _$DoctorWithServicesModelImpl
        >
    implements _$$DoctorWithServicesModelImplCopyWith<$Res> {
  __$$DoctorWithServicesModelImplCopyWithImpl(
    _$DoctorWithServicesModelImpl _value,
    $Res Function(_$DoctorWithServicesModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorWithServicesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? specialty = null,
    Object? qualification = freezed,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isOnline = null,
    Object? experienceYears = null,
    Object? consultationFee = null,
    Object? isActive = null,
    Object? serviceCount = null,
    Object? serviceIds = null,
  }) {
    return _then(
      _$DoctorWithServicesModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        specialty: null == specialty
            ? _value.specialty
            : specialty // ignore: cast_nullable_to_non_nullable
                  as String,
        qualification: freezed == qualification
            ? _value.qualification
            : qualification // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isOnline: null == isOnline
            ? _value.isOnline
            : isOnline // ignore: cast_nullable_to_non_nullable
                  as bool,
        experienceYears: null == experienceYears
            ? _value.experienceYears
            : experienceYears // ignore: cast_nullable_to_non_nullable
                  as int,
        consultationFee: null == consultationFee
            ? _value.consultationFee
            : consultationFee // ignore: cast_nullable_to_non_nullable
                  as double,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        serviceCount: null == serviceCount
            ? _value.serviceCount
            : serviceCount // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceIds: null == serviceIds
            ? _value._serviceIds
            : serviceIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DoctorWithServicesModelImpl implements _DoctorWithServicesModel {
  const _$DoctorWithServicesModelImpl({
    required this.id,
    @JsonKey(name: 'full_name') required this.fullName,
    required this.specialty,
    this.qualification,
    this.bio,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    this.rating = 0.0,
    @JsonKey(name: 'review_count') this.reviewCount = 0,
    @JsonKey(name: 'is_online') this.isOnline = false,
    @JsonKey(name: 'experience_years') this.experienceYears = 0,
    @JsonKey(name: 'consultation_fee') this.consultationFee = 0.0,
    @JsonKey(name: 'is_active') this.isActive = false,
    @JsonKey(name: 'service_count') this.serviceCount = 0,
    @JsonKey(
      name: 'service_ids',
      fromJson: _serviceIdsFromJson,
      toJson: _serviceIdsToJson,
    )
    final List<String> serviceIds = const [],
  }) : _serviceIds = serviceIds;

  factory _$DoctorWithServicesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DoctorWithServicesModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'full_name')
  final String fullName;
  @override
  final String specialty;
  @override
  final String? qualification;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'review_count')
  final int reviewCount;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  @JsonKey(name: 'experience_years')
  final int experienceYears;
  @override
  @JsonKey(name: 'consultation_fee')
  final double consultationFee;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'service_count')
  final int serviceCount;
  final List<String> _serviceIds;
  @override
  @JsonKey(
    name: 'service_ids',
    fromJson: _serviceIdsFromJson,
    toJson: _serviceIdsToJson,
  )
  List<String> get serviceIds {
    if (_serviceIds is EqualUnmodifiableListView) return _serviceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceIds);
  }

  @override
  String toString() {
    return 'DoctorWithServicesModel(id: $id, fullName: $fullName, specialty: $specialty, qualification: $qualification, bio: $bio, avatarUrl: $avatarUrl, rating: $rating, reviewCount: $reviewCount, isOnline: $isOnline, experienceYears: $experienceYears, consultationFee: $consultationFee, isActive: $isActive, serviceCount: $serviceCount, serviceIds: $serviceIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorWithServicesModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.qualification, qualification) ||
                other.qualification == qualification) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.experienceYears, experienceYears) ||
                other.experienceYears == experienceYears) &&
            (identical(other.consultationFee, consultationFee) ||
                other.consultationFee == consultationFee) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.serviceCount, serviceCount) ||
                other.serviceCount == serviceCount) &&
            const DeepCollectionEquality().equals(
              other._serviceIds,
              _serviceIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    specialty,
    qualification,
    bio,
    avatarUrl,
    rating,
    reviewCount,
    isOnline,
    experienceYears,
    consultationFee,
    isActive,
    serviceCount,
    const DeepCollectionEquality().hash(_serviceIds),
  );

  /// Create a copy of DoctorWithServicesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorWithServicesModelImplCopyWith<_$DoctorWithServicesModelImpl>
  get copyWith =>
      __$$DoctorWithServicesModelImplCopyWithImpl<
        _$DoctorWithServicesModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DoctorWithServicesModelImplToJson(this);
  }
}

abstract class _DoctorWithServicesModel implements DoctorWithServicesModel {
  const factory _DoctorWithServicesModel({
    required final String id,
    @JsonKey(name: 'full_name') required final String fullName,
    required final String specialty,
    final String? qualification,
    final String? bio,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    final double rating,
    @JsonKey(name: 'review_count') final int reviewCount,
    @JsonKey(name: 'is_online') final bool isOnline,
    @JsonKey(name: 'experience_years') final int experienceYears,
    @JsonKey(name: 'consultation_fee') final double consultationFee,
    @JsonKey(name: 'is_active') final bool isActive,
    @JsonKey(name: 'service_count') final int serviceCount,
    @JsonKey(
      name: 'service_ids',
      fromJson: _serviceIdsFromJson,
      toJson: _serviceIdsToJson,
    )
    final List<String> serviceIds,
  }) = _$DoctorWithServicesModelImpl;

  factory _DoctorWithServicesModel.fromJson(Map<String, dynamic> json) =
      _$DoctorWithServicesModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'full_name')
  String get fullName;
  @override
  String get specialty;
  @override
  String? get qualification;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  double get rating;
  @override
  @JsonKey(name: 'review_count')
  int get reviewCount;
  @override
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @override
  @JsonKey(name: 'experience_years')
  int get experienceYears;
  @override
  @JsonKey(name: 'consultation_fee')
  double get consultationFee;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'service_count')
  int get serviceCount;
  @override
  @JsonKey(
    name: 'service_ids',
    fromJson: _serviceIdsFromJson,
    toJson: _serviceIdsToJson,
  )
  List<String> get serviceIds;

  /// Create a copy of DoctorWithServicesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorWithServicesModelImplCopyWith<_$DoctorWithServicesModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
