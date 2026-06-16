// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dental_service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DentalServiceModel _$DentalServiceModelFromJson(Map<String, dynamic> json) {
  return _DentalServiceModel.fromJson(json);
}

/// @nodoc
mixin _$DentalServiceModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon_url')
  String? get iconUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this DentalServiceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DentalServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DentalServiceModelCopyWith<DentalServiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DentalServiceModelCopyWith<$Res> {
  factory $DentalServiceModelCopyWith(
    DentalServiceModel value,
    $Res Function(DentalServiceModel) then,
  ) = _$DentalServiceModelCopyWithImpl<$Res, DentalServiceModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    double price,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'icon_url') String? iconUrl,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class _$DentalServiceModelCopyWithImpl<$Res, $Val extends DentalServiceModel>
    implements $DentalServiceModelCopyWith<$Res> {
  _$DentalServiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DentalServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? durationMinutes = null,
    Object? iconUrl = freezed,
    Object? category = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            iconUrl: freezed == iconUrl
                ? _value.iconUrl
                : iconUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DentalServiceModelImplCopyWith<$Res>
    implements $DentalServiceModelCopyWith<$Res> {
  factory _$$DentalServiceModelImplCopyWith(
    _$DentalServiceModelImpl value,
    $Res Function(_$DentalServiceModelImpl) then,
  ) = __$$DentalServiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? description,
    double price,
    @JsonKey(name: 'duration_minutes') int durationMinutes,
    @JsonKey(name: 'icon_url') String? iconUrl,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'is_active') bool isActive,
  });
}

/// @nodoc
class __$$DentalServiceModelImplCopyWithImpl<$Res>
    extends _$DentalServiceModelCopyWithImpl<$Res, _$DentalServiceModelImpl>
    implements _$$DentalServiceModelImplCopyWith<$Res> {
  __$$DentalServiceModelImplCopyWithImpl(
    _$DentalServiceModelImpl _value,
    $Res Function(_$DentalServiceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DentalServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? durationMinutes = null,
    Object? iconUrl = freezed,
    Object? category = freezed,
    Object? isActive = null,
  }) {
    return _then(
      _$DentalServiceModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        iconUrl: freezed == iconUrl
            ? _value.iconUrl
            : iconUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DentalServiceModelImpl implements _DentalServiceModel {
  const _$DentalServiceModelImpl({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    @JsonKey(name: 'duration_minutes') required this.durationMinutes,
    @JsonKey(name: 'icon_url') this.iconUrl,
    @JsonKey(name: 'category') this.category,
    @JsonKey(name: 'is_active') this.isActive = true,
  });

  factory _$DentalServiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DentalServiceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final double price;
  @override
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  @override
  @JsonKey(name: 'icon_url')
  final String? iconUrl;
  @override
  @JsonKey(name: 'category')
  final String? category;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'DentalServiceModel(id: $id, name: $name, description: $description, price: $price, durationMinutes: $durationMinutes, iconUrl: $iconUrl, category: $category, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DentalServiceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    price,
    durationMinutes,
    iconUrl,
    category,
    isActive,
  );

  /// Create a copy of DentalServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DentalServiceModelImplCopyWith<_$DentalServiceModelImpl> get copyWith =>
      __$$DentalServiceModelImplCopyWithImpl<_$DentalServiceModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DentalServiceModelImplToJson(this);
  }
}

abstract class _DentalServiceModel implements DentalServiceModel {
  const factory _DentalServiceModel({
    required final String id,
    required final String name,
    final String? description,
    required final double price,
    @JsonKey(name: 'duration_minutes') required final int durationMinutes,
    @JsonKey(name: 'icon_url') final String? iconUrl,
    @JsonKey(name: 'category') final String? category,
    @JsonKey(name: 'is_active') final bool isActive,
  }) = _$DentalServiceModelImpl;

  factory _DentalServiceModel.fromJson(Map<String, dynamic> json) =
      _$DentalServiceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get price;
  @override
  @JsonKey(name: 'duration_minutes')
  int get durationMinutes;
  @override
  @JsonKey(name: 'icon_url')
  String? get iconUrl;
  @override
  @JsonKey(name: 'category')
  String? get category;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of DentalServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DentalServiceModelImplCopyWith<_$DentalServiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
