// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presented_offering_targeting_context_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PresentedOfferingTargetingContext {
  /// The revision of the targeting used to obtain this object
  int get revision;

  /// The rule id from the targeting used to obtain this object
  String get ruleId;

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PresentedOfferingTargetingContextCopyWith<PresentedOfferingTargetingContext>
      get copyWith => _$PresentedOfferingTargetingContextCopyWithImpl<
              PresentedOfferingTargetingContext>(
          this as PresentedOfferingTargetingContext, _$identity);

  /// Serializes this PresentedOfferingTargetingContext to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PresentedOfferingTargetingContext &&
            (identical(other.revision, revision) ||
                other.revision == revision) &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, revision, ruleId);

  @override
  String toString() {
    return 'PresentedOfferingTargetingContext(revision: $revision, ruleId: $ruleId)';
  }
}

/// @nodoc
abstract mixin class $PresentedOfferingTargetingContextCopyWith<$Res> {
  factory $PresentedOfferingTargetingContextCopyWith(
          PresentedOfferingTargetingContext value,
          $Res Function(PresentedOfferingTargetingContext) _then) =
      _$PresentedOfferingTargetingContextCopyWithImpl;
  @useResult
  $Res call({int revision, String ruleId});
}

/// @nodoc
class _$PresentedOfferingTargetingContextCopyWithImpl<$Res>
    implements $PresentedOfferingTargetingContextCopyWith<$Res> {
  _$PresentedOfferingTargetingContextCopyWithImpl(this._self, this._then);

  final PresentedOfferingTargetingContext _self;
  final $Res Function(PresentedOfferingTargetingContext) _then;

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? revision = null,
    Object? ruleId = null,
  }) {
    return _then(_self.copyWith(
      revision: null == revision
          ? _self.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      ruleId: null == ruleId
          ? _self.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PresentedOfferingTargetingContext
    implements PresentedOfferingTargetingContext {
  const _PresentedOfferingTargetingContext(this.revision, this.ruleId);
  factory _PresentedOfferingTargetingContext.fromJson(
          Map<String, dynamic> json) =>
      _$PresentedOfferingTargetingContextFromJson(json);

  /// The revision of the targeting used to obtain this object
  @override
  final int revision;

  /// The rule id from the targeting used to obtain this object
  @override
  final String ruleId;

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PresentedOfferingTargetingContextCopyWith<
          _PresentedOfferingTargetingContext>
      get copyWith => __$PresentedOfferingTargetingContextCopyWithImpl<
          _PresentedOfferingTargetingContext>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PresentedOfferingTargetingContextToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PresentedOfferingTargetingContext &&
            (identical(other.revision, revision) ||
                other.revision == revision) &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, revision, ruleId);

  @override
  String toString() {
    return 'PresentedOfferingTargetingContext(revision: $revision, ruleId: $ruleId)';
  }
}

/// @nodoc
abstract mixin class _$PresentedOfferingTargetingContextCopyWith<$Res>
    implements $PresentedOfferingTargetingContextCopyWith<$Res> {
  factory _$PresentedOfferingTargetingContextCopyWith(
          _PresentedOfferingTargetingContext value,
          $Res Function(_PresentedOfferingTargetingContext) _then) =
      __$PresentedOfferingTargetingContextCopyWithImpl;
  @override
  @useResult
  $Res call({int revision, String ruleId});
}

/// @nodoc
class __$PresentedOfferingTargetingContextCopyWithImpl<$Res>
    implements _$PresentedOfferingTargetingContextCopyWith<$Res> {
  __$PresentedOfferingTargetingContextCopyWithImpl(this._self, this._then);

  final _PresentedOfferingTargetingContext _self;
  final $Res Function(_PresentedOfferingTargetingContext) _then;

  /// Create a copy of PresentedOfferingTargetingContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? revision = null,
    Object? ruleId = null,
  }) {
    return _then(_PresentedOfferingTargetingContext(
      null == revision
          ? _self.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      null == ruleId
          ? _self.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
