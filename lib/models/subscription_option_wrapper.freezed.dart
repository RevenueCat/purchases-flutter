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
  @JsonKey(name: 'pricingPhases')
  List<PricingPhase> get pricingPhases => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'isBasePlan')
  bool get isBasePlan => throw _privateConstructorUsedError;
  @JsonKey(name: 'billingPeriod', nullable: true)
  Period? get billingPeriod => throw _privateConstructorUsedError;
  @JsonKey(name: 'fullPricePhase', nullable: true)
  PricingPhase? get fullPricePhase => throw _privateConstructorUsedError;
  @JsonKey(name: 'freePhase', nullable: true)
  PricingPhase? get freePhase => throw _privateConstructorUsedError;
  @JsonKey(name: 'introPhase', nullable: true)
  PricingPhase? get introPhase => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'id')
          String id,
      @JsonKey(name: 'storeProductId')
          String storeProductId,
      @JsonKey(name: 'productId')
          String productId,
      @JsonKey(name: 'pricingPhases')
          List<PricingPhase> pricingPhases,
      @JsonKey(name: 'tags')
          List<String> tags,
      @JsonKey(name: 'isBasePlan')
          bool isBasePlan,
      @JsonKey(name: 'billingPeriod', nullable: true)
          Period? billingPeriod,
      @JsonKey(name: 'fullPricePhase', nullable: true)
          PricingPhase? fullPricePhase,
      @JsonKey(name: 'freePhase', nullable: true)
          PricingPhase? freePhase,
      @JsonKey(name: 'introPhase', nullable: true)
          PricingPhase? introPhase});

  $PeriodCopyWith<$Res>? get billingPeriod;
  $PricingPhaseCopyWith<$Res>? get fullPricePhase;
  $PricingPhaseCopyWith<$Res>? get freePhase;
  $PricingPhaseCopyWith<$Res>? get introPhase;
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
    Object? pricingPhases = null,
    Object? tags = null,
    Object? isBasePlan = null,
    Object? billingPeriod = freezed,
    Object? fullPricePhase = freezed,
    Object? freePhase = freezed,
    Object? introPhase = freezed,
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
      pricingPhases: null == pricingPhases
          ? _value.pricingPhases
          : pricingPhases // ignore: cast_nullable_to_non_nullable
              as List<PricingPhase>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isBasePlan: null == isBasePlan
          ? _value.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
      billingPeriod: freezed == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      fullPricePhase: freezed == fullPricePhase
          ? _value.fullPricePhase
          : fullPricePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freePhase: freezed == freePhase
          ? _value.freePhase
          : freePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      introPhase: freezed == introPhase
          ? _value.introPhase
          : introPhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PeriodCopyWith<$Res>? get billingPeriod {
    if (_value.billingPeriod == null) {
      return null;
    }

    return $PeriodCopyWith<$Res>(_value.billingPeriod!, (value) {
      return _then(_value.copyWith(billingPeriod: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get fullPricePhase {
    if (_value.fullPricePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_value.fullPricePhase!, (value) {
      return _then(_value.copyWith(fullPricePhase: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get freePhase {
    if (_value.freePhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_value.freePhase!, (value) {
      return _then(_value.copyWith(freePhase: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PricingPhaseCopyWith<$Res>? get introPhase {
    if (_value.introPhase == null) {
      return null;
    }

    return $PricingPhaseCopyWith<$Res>(_value.introPhase!, (value) {
      return _then(_value.copyWith(introPhase: value) as $Val);
    });
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
      {@JsonKey(name: 'id')
          String id,
      @JsonKey(name: 'storeProductId')
          String storeProductId,
      @JsonKey(name: 'productId')
          String productId,
      @JsonKey(name: 'pricingPhases')
          List<PricingPhase> pricingPhases,
      @JsonKey(name: 'tags')
          List<String> tags,
      @JsonKey(name: 'isBasePlan')
          bool isBasePlan,
      @JsonKey(name: 'billingPeriod', nullable: true)
          Period? billingPeriod,
      @JsonKey(name: 'fullPricePhase', nullable: true)
          PricingPhase? fullPricePhase,
      @JsonKey(name: 'freePhase', nullable: true)
          PricingPhase? freePhase,
      @JsonKey(name: 'introPhase', nullable: true)
          PricingPhase? introPhase});

  @override
  $PeriodCopyWith<$Res>? get billingPeriod;
  @override
  $PricingPhaseCopyWith<$Res>? get fullPricePhase;
  @override
  $PricingPhaseCopyWith<$Res>? get freePhase;
  @override
  $PricingPhaseCopyWith<$Res>? get introPhase;
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
    Object? pricingPhases = null,
    Object? tags = null,
    Object? isBasePlan = null,
    Object? billingPeriod = freezed,
    Object? fullPricePhase = freezed,
    Object? freePhase = freezed,
    Object? introPhase = freezed,
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
      null == pricingPhases
          ? _value._pricingPhases
          : pricingPhases // ignore: cast_nullable_to_non_nullable
              as List<PricingPhase>,
      null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == isBasePlan
          ? _value.isBasePlan
          : isBasePlan // ignore: cast_nullable_to_non_nullable
              as bool,
      freezed == billingPeriod
          ? _value.billingPeriod
          : billingPeriod // ignore: cast_nullable_to_non_nullable
              as Period?,
      freezed == fullPricePhase
          ? _value.fullPricePhase
          : fullPricePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == freePhase
          ? _value.freePhase
          : freePhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
      freezed == introPhase
          ? _value.introPhase
          : introPhase // ignore: cast_nullable_to_non_nullable
              as PricingPhase?,
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
      @JsonKey(name: 'pricingPhases') final List<PricingPhase> pricingPhases,
      @JsonKey(name: 'tags') final List<String> tags,
      @JsonKey(name: 'isBasePlan') this.isBasePlan,
      @JsonKey(name: 'billingPeriod', nullable: true) this.billingPeriod,
      @JsonKey(name: 'fullPricePhase', nullable: true) this.fullPricePhase,
      @JsonKey(name: 'freePhase', nullable: true) this.freePhase,
      @JsonKey(name: 'introPhase', nullable: true) this.introPhase)
      : _pricingPhases = pricingPhases,
        _tags = tags;

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
  final List<PricingPhase> _pricingPhases;
  @override
  @JsonKey(name: 'pricingPhases')
  List<PricingPhase> get pricingPhases {
    if (_pricingPhases is EqualUnmodifiableListView) return _pricingPhases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pricingPhases);
  }

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
  @JsonKey(name: 'billingPeriod', nullable: true)
  final Period? billingPeriod;
  @override
  @JsonKey(name: 'fullPricePhase', nullable: true)
  final PricingPhase? fullPricePhase;
  @override
  @JsonKey(name: 'freePhase', nullable: true)
  final PricingPhase? freePhase;
  @override
  @JsonKey(name: 'introPhase', nullable: true)
  final PricingPhase? introPhase;

  @override
  String toString() {
    return 'SubscriptionOption(id: $id, storeProductId: $storeProductId, productId: $productId, pricingPhases: $pricingPhases, tags: $tags, isBasePlan: $isBasePlan, billingPeriod: $billingPeriod, fullPricePhase: $fullPricePhase, freePhase: $freePhase, introPhase: $introPhase)';
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
            const DeepCollectionEquality()
                .equals(other._pricingPhases, _pricingPhases) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isBasePlan, isBasePlan) ||
                other.isBasePlan == isBasePlan) &&
            (identical(other.billingPeriod, billingPeriod) ||
                other.billingPeriod == billingPeriod) &&
            (identical(other.fullPricePhase, fullPricePhase) ||
                other.fullPricePhase == fullPricePhase) &&
            (identical(other.freePhase, freePhase) ||
                other.freePhase == freePhase) &&
            (identical(other.introPhase, introPhase) ||
                other.introPhase == introPhase));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      storeProductId,
      productId,
      const DeepCollectionEquality().hash(_pricingPhases),
      const DeepCollectionEquality().hash(_tags),
      isBasePlan,
      billingPeriod,
      fullPricePhase,
      freePhase,
      introPhase);

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
      @JsonKey(name: 'id')
          final String id,
      @JsonKey(name: 'storeProductId')
          final String storeProductId,
      @JsonKey(name: 'productId')
          final String productId,
      @JsonKey(name: 'pricingPhases')
          final List<PricingPhase> pricingPhases,
      @JsonKey(name: 'tags')
          final List<String> tags,
      @JsonKey(name: 'isBasePlan')
          final bool isBasePlan,
      @JsonKey(name: 'billingPeriod', nullable: true)
          final Period? billingPeriod,
      @JsonKey(name: 'fullPricePhase', nullable: true)
          final PricingPhase? fullPricePhase,
      @JsonKey(name: 'freePhase', nullable: true)
          final PricingPhase? freePhase,
      @JsonKey(name: 'introPhase', nullable: true)
          final PricingPhase? introPhase) = _$_SubscriptionOption;

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
  @JsonKey(name: 'pricingPhases')
  List<PricingPhase> get pricingPhases;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags;
  @override
  @JsonKey(name: 'isBasePlan')
  bool get isBasePlan;
  @override
  @JsonKey(name: 'billingPeriod', nullable: true)
  Period? get billingPeriod;
  @override
  @JsonKey(name: 'fullPricePhase', nullable: true)
  PricingPhase? get fullPricePhase;
  @override
  @JsonKey(name: 'freePhase', nullable: true)
  PricingPhase? get freePhase;
  @override
  @JsonKey(name: 'introPhase', nullable: true)
  PricingPhase? get introPhase;
  @override
  @JsonKey(ignore: true)
  _$$_SubscriptionOptionCopyWith<_$_SubscriptionOption> get copyWith =>
      throw _privateConstructorUsedError;
}
