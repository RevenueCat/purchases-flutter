// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_option_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubscriptionOption _$SubscriptionOptionFromJson(Map<String, dynamic> json) {
  return _SubscriptionOption.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionOption {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'storeProductId')
  String get storeProductId => throw _privateConstructorUsedError;
  @JsonKey(name: 'productId')
  String get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'isBasePlan')
  bool get isBasePlan => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubscriptionOptionCopyWith<SubscriptionOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionOptionCopyWith<$Res> {
  factory $SubscriptionOptionCopyWith(
          SubscriptionOption value, $Res Function(SubscriptionOption) then) =
      _$SubscriptionOptionCopyWithImpl<$Res, SubscriptionOption>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'storeProductId') String storeProductId,
      @JsonKey(name: 'productId') String productId,
      @JsonKey(name: 'tags') List<String> tags,
      @JsonKey(name: 'isBasePlan') bool isBasePlan});
}

/// @nodoc
class _$SubscriptionOptionCopyWithImpl<$Res, $Val extends SubscriptionOption>
    implements $SubscriptionOptionCopyWith<$Res> {
  _$SubscriptionOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeProductId = null,
    Object? productId = null,
    Object? tags = null,
    Object? isBasePlan = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storeProductId: null == storeProductId
          ? _value.storeProductId
          : storeProductId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isBasePlan: null == isBasePlan
          ? _value.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubscriptionOptionCopyWith<$Res>
    implements $SubscriptionOptionCopyWith<$Res> {
  factory _$$_SubscriptionOptionCopyWith(_$_SubscriptionOption value,
          $Res Function(_$_SubscriptionOption) then) =
      __$$_SubscriptionOptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'storeProductId') String storeProductId,
      @JsonKey(name: 'productId') String productId,
      @JsonKey(name: 'tags') List<String> tags,
      @JsonKey(name: 'isBasePlan') bool isBasePlan});
}

/// @nodoc
class __$$_SubscriptionOptionCopyWithImpl<$Res>
    extends _$SubscriptionOptionCopyWithImpl<$Res, _$_SubscriptionOption>
    implements _$$_SubscriptionOptionCopyWith<$Res> {
  __$$_SubscriptionOptionCopyWithImpl(
      _$_SubscriptionOption _value, $Res Function(_$_SubscriptionOption) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeProductId = null,
    Object? productId = null,
    Object? tags = null,
    Object? isBasePlan = null,
  }) {
    return _then(_$_SubscriptionOption(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == storeProductId
          ? _value.storeProductId
          : storeProductId // ignore: cast_nullable_to_non_nullable
              as String,
      null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == isBasePlan
          ? _value.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubscriptionOption implements _SubscriptionOption {
  const _$_SubscriptionOption(
      @JsonKey(name: 'id') this.id,
      @JsonKey(name: 'storeProductId') this.storeProductId,
      @JsonKey(name: 'productId') this.productId,
      @JsonKey(name: 'tags') final List<String> tags,
      @JsonKey(name: 'isBasePlan') this.isBasePlan)
      : _tags = tags;

  factory _$_SubscriptionOption.fromJson(Map<String, dynamic> json) =>
      _$$_SubscriptionOptionFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'storeProductId')
  final String storeProductId;
  @override
  @JsonKey(name: 'productId')
  final String productId;
  final List<String> _tags;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'isBasePlan')
  final bool isBasePlan;

  @override
  String toString() {
    return 'SubscriptionOption(id: $id, storeProductId: $storeProductId, productId: $productId, tags: $tags, isBasePlan: $isBasePlan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SubscriptionOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeProductId, storeProductId) ||
                other.storeProductId == storeProductId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isBasePlan, isBasePlan) ||
                other.isBasePlan == isBasePlan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, storeProductId, productId,
      const DeepCollectionEquality().hash(_tags), isBasePlan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubscriptionOptionCopyWith<_$_SubscriptionOption> get copyWith =>
      __$$_SubscriptionOptionCopyWithImpl<_$_SubscriptionOption>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubscriptionOptionToJson(
      this,
    );
  }
}

abstract class _SubscriptionOption implements SubscriptionOption {
  const factory _SubscriptionOption(
          @JsonKey(name: 'id') final String id,
          @JsonKey(name: 'storeProductId') final String storeProductId,
          @JsonKey(name: 'productId') final String productId,
          @JsonKey(name: 'tags') final List<String> tags,
          @JsonKey(name: 'isBasePlan') final bool isBasePlan) =
      _$_SubscriptionOption;

  factory _SubscriptionOption.fromJson(Map<String, dynamic> json) =
      _$_SubscriptionOption.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'storeProductId')
  String get storeProductId;
  @override
  @JsonKey(name: 'productId')
  String get productId;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags;
  @override
  @JsonKey(name: 'isBasePlan')
  bool get isBasePlan;
  @override
  @JsonKey(ignore: true)
  _$$_SubscriptionOptionCopyWith<_$_SubscriptionOption> get copyWith =>
      throw _privateConstructorUsedError;
}
