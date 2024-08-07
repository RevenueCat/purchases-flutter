// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presented_offering_context_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PresentedOfferingContext _$PresentedOfferingContextFromJson(
    Map<String, dynamic> json) {
  return _PresentedOfferingContext.fromJson(json);
}

/// @nodoc
mixin _$PresentedOfferingContext {
  /// The identifier of the offering used to obtain this object
  String get offeringIdentifier => throw _privateConstructorUsedError;

  /// The identifier of the placement used to obtain this object
  String? get placementIdentifier => throw _privateConstructorUsedError;

  /// The revision of the targeting used to obtain this object
  PresentedOfferingTargetingContext? get targetingContext =>
      throw _privateConstructorUsedError;

  /// Serializes this PresentedOfferingContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresentedOfferingContextCopyWith<PresentedOfferingContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresentedOfferingContextCopyWith<$Res> {
  factory $PresentedOfferingContextCopyWith(PresentedOfferingContext value,
          $Res Function(PresentedOfferingContext) then) =
      _$PresentedOfferingContextCopyWithImpl<$Res, PresentedOfferingContext>;
  @useResult
  $Res call(
      {String offeringIdentifier,
      String? placementIdentifier,
      PresentedOfferingTargetingContext? targetingContext});

  $PresentedOfferingTargetingContextCopyWith<$Res>? get targetingContext;
}

/// @nodoc
class _$PresentedOfferingContextCopyWithImpl<$Res,
        $Val extends PresentedOfferingContext>
    implements $PresentedOfferingContextCopyWith<$Res> {
  _$PresentedOfferingContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offeringIdentifier = null,
    Object? placementIdentifier = freezed,
    Object? targetingContext = freezed,
  }) {
    return _then(_value.copyWith(
      offeringIdentifier: null == offeringIdentifier
          ? _value.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      placementIdentifier: freezed == placementIdentifier
          ? _value.placementIdentifier
          : placementIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      targetingContext: freezed == targetingContext
          ? _value.targetingContext
          : targetingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingTargetingContext?,
    ) as $Val);
  }

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingTargetingContextCopyWith<$Res>? get targetingContext {
    if (_value.targetingContext == null) {
      return null;
    }

    return $PresentedOfferingTargetingContextCopyWith<$Res>(
        _value.targetingContext!, (value) {
      return _then(_value.copyWith(targetingContext: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresentedOfferingContextImplCopyWith<$Res>
    implements $PresentedOfferingContextCopyWith<$Res> {
  factory _$$PresentedOfferingContextImplCopyWith(
          _$PresentedOfferingContextImpl value,
          $Res Function(_$PresentedOfferingContextImpl) then) =
      __$$PresentedOfferingContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String offeringIdentifier,
      String? placementIdentifier,
      PresentedOfferingTargetingContext? targetingContext});

  @override
  $PresentedOfferingTargetingContextCopyWith<$Res>? get targetingContext;
}

/// @nodoc
class __$$PresentedOfferingContextImplCopyWithImpl<$Res>
    extends _$PresentedOfferingContextCopyWithImpl<$Res,
        _$PresentedOfferingContextImpl>
    implements _$$PresentedOfferingContextImplCopyWith<$Res> {
  __$$PresentedOfferingContextImplCopyWithImpl(
      _$PresentedOfferingContextImpl _value,
      $Res Function(_$PresentedOfferingContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offeringIdentifier = null,
    Object? placementIdentifier = freezed,
    Object? targetingContext = freezed,
  }) {
    return _then(_$PresentedOfferingContextImpl(
      null == offeringIdentifier
          ? _value.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == placementIdentifier
          ? _value.placementIdentifier
          : placementIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == targetingContext
          ? _value.targetingContext
          : targetingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingTargetingContext?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentedOfferingContextImpl implements _PresentedOfferingContext {
  const _$PresentedOfferingContextImpl(
      this.offeringIdentifier, this.placementIdentifier, this.targetingContext);

  factory _$PresentedOfferingContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresentedOfferingContextImplFromJson(json);

  /// The identifier of the offering used to obtain this object
  @override
  final String offeringIdentifier;

  /// The identifier of the placement used to obtain this object
  @override
  final String? placementIdentifier;

  /// The revision of the targeting used to obtain this object
  @override
  final PresentedOfferingTargetingContext? targetingContext;

  @override
  String toString() {
    return 'PresentedOfferingContext(offeringIdentifier: $offeringIdentifier, placementIdentifier: $placementIdentifier, targetingContext: $targetingContext)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentedOfferingContextImpl &&
            (identical(other.offeringIdentifier, offeringIdentifier) ||
                other.offeringIdentifier == offeringIdentifier) &&
            (identical(other.placementIdentifier, placementIdentifier) ||
                other.placementIdentifier == placementIdentifier) &&
            (identical(other.targetingContext, targetingContext) ||
                other.targetingContext == targetingContext));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, offeringIdentifier, placementIdentifier, targetingContext);

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentedOfferingContextImplCopyWith<_$PresentedOfferingContextImpl>
      get copyWith => __$$PresentedOfferingContextImplCopyWithImpl<
          _$PresentedOfferingContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentedOfferingContextImplToJson(
      this,
    );
  }
}

abstract class _PresentedOfferingContext implements PresentedOfferingContext {
  const factory _PresentedOfferingContext(
          final String offeringIdentifier,
          final String? placementIdentifier,
          final PresentedOfferingTargetingContext? targetingContext) =
      _$PresentedOfferingContextImpl;

  factory _PresentedOfferingContext.fromJson(Map<String, dynamic> json) =
      _$PresentedOfferingContextImpl.fromJson;

  /// The identifier of the offering used to obtain this object
  @override
  String get offeringIdentifier;

  /// The identifier of the placement used to obtain this object
  @override
  String? get placementIdentifier;

  /// The revision of the targeting used to obtain this object
  @override
  PresentedOfferingTargetingContext? get targetingContext;

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresentedOfferingContextImplCopyWith<_$PresentedOfferingContextImpl>
      get copyWith => throw _privateConstructorUsedError;
}
