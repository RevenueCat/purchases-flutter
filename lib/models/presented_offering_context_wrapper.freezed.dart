// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presented_offering_context_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PresentedOfferingContext {
  /// The identifier of the offering used to obtain this object
  String get offeringIdentifier;

  /// The identifier of the placement used to obtain this object
  String? get placementIdentifier;

  /// The revision of the targeting used to obtain this object
  PresentedOfferingTargetingContext? get targetingContext;

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PresentedOfferingContextCopyWith<PresentedOfferingContext> get copyWith =>
      _$PresentedOfferingContextCopyWithImpl<PresentedOfferingContext>(
          this as PresentedOfferingContext, _$identity);

  /// Serializes this PresentedOfferingContext to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PresentedOfferingContext &&
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

  @override
  String toString() {
    return 'PresentedOfferingContext(offeringIdentifier: $offeringIdentifier, placementIdentifier: $placementIdentifier, targetingContext: $targetingContext)';
  }
}

/// @nodoc
abstract mixin class $PresentedOfferingContextCopyWith<$Res> {
  factory $PresentedOfferingContextCopyWith(PresentedOfferingContext value,
          $Res Function(PresentedOfferingContext) _then) =
      _$PresentedOfferingContextCopyWithImpl;
  @useResult
  $Res call(
      {String offeringIdentifier,
      String? placementIdentifier,
      PresentedOfferingTargetingContext? targetingContext});

  $PresentedOfferingTargetingContextCopyWith<$Res>? get targetingContext;
}

/// @nodoc
class _$PresentedOfferingContextCopyWithImpl<$Res>
    implements $PresentedOfferingContextCopyWith<$Res> {
  _$PresentedOfferingContextCopyWithImpl(this._self, this._then);

  final PresentedOfferingContext _self;
  final $Res Function(PresentedOfferingContext) _then;

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offeringIdentifier = null,
    Object? placementIdentifier = freezed,
    Object? targetingContext = freezed,
  }) {
    return _then(_self.copyWith(
      offeringIdentifier: null == offeringIdentifier
          ? _self.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      placementIdentifier: freezed == placementIdentifier
          ? _self.placementIdentifier
          : placementIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      targetingContext: freezed == targetingContext
          ? _self.targetingContext
          : targetingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingTargetingContext?,
    ));
  }

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingTargetingContextCopyWith<$Res>? get targetingContext {
    if (_self.targetingContext == null) {
      return null;
    }

    return $PresentedOfferingTargetingContextCopyWith<$Res>(
        _self.targetingContext!, (value) {
      return _then(_self.copyWith(targetingContext: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _PresentedOfferingContext implements PresentedOfferingContext {
  const _PresentedOfferingContext(
      this.offeringIdentifier, this.placementIdentifier, this.targetingContext);
  factory _PresentedOfferingContext.fromJson(Map<String, dynamic> json) =>
      _$PresentedOfferingContextFromJson(json);

  /// The identifier of the offering used to obtain this object
  @override
  final String offeringIdentifier;

  /// The identifier of the placement used to obtain this object
  @override
  final String? placementIdentifier;

  /// The revision of the targeting used to obtain this object
  @override
  final PresentedOfferingTargetingContext? targetingContext;

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PresentedOfferingContextCopyWith<_PresentedOfferingContext> get copyWith =>
      __$PresentedOfferingContextCopyWithImpl<_PresentedOfferingContext>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PresentedOfferingContextToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PresentedOfferingContext &&
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

  @override
  String toString() {
    return 'PresentedOfferingContext(offeringIdentifier: $offeringIdentifier, placementIdentifier: $placementIdentifier, targetingContext: $targetingContext)';
  }
}

/// @nodoc
abstract mixin class _$PresentedOfferingContextCopyWith<$Res>
    implements $PresentedOfferingContextCopyWith<$Res> {
  factory _$PresentedOfferingContextCopyWith(_PresentedOfferingContext value,
          $Res Function(_PresentedOfferingContext) _then) =
      __$PresentedOfferingContextCopyWithImpl;
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
class __$PresentedOfferingContextCopyWithImpl<$Res>
    implements _$PresentedOfferingContextCopyWith<$Res> {
  __$PresentedOfferingContextCopyWithImpl(this._self, this._then);

  final _PresentedOfferingContext _self;
  final $Res Function(_PresentedOfferingContext) _then;

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? offeringIdentifier = null,
    Object? placementIdentifier = freezed,
    Object? targetingContext = freezed,
  }) {
    return _then(_PresentedOfferingContext(
      null == offeringIdentifier
          ? _self.offeringIdentifier
          : offeringIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == placementIdentifier
          ? _self.placementIdentifier
          : placementIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == targetingContext
          ? _self.targetingContext
          : targetingContext // ignore: cast_nullable_to_non_nullable
              as PresentedOfferingTargetingContext?,
    ));
  }

  /// Create a copy of PresentedOfferingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresentedOfferingTargetingContextCopyWith<$Res>? get targetingContext {
    if (_self.targetingContext == null) {
      return null;
    }

    return $PresentedOfferingTargetingContextCopyWith<$Res>(
        _self.targetingContext!, (value) {
      return _then(_self.copyWith(targetingContext: value));
    });
  }
}

// dart format on
