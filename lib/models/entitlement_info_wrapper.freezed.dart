// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement_info_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EntitlementInfo _$EntitlementInfoFromJson(Map<String, dynamic> json) {
  return _EntitlementInfo.fromJson(json);
}

/// @nodoc
mixin _$EntitlementInfo {
  /// The entitlement identifier configured in the RevenueCat dashboard
  String get identifier => throw _privateConstructorUsedError;

  /// True if the user has access to this entitlement
  bool get isActive => throw _privateConstructorUsedError;

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate).
  bool get willRenew => throw _privateConstructorUsedError;

  /// The latest purchase or renewal date for the entitlement.
  String get latestPurchaseDate => throw _privateConstructorUsedError;

  /// The first date this entitlement was purchased
  String get originalPurchaseDate => throw _privateConstructorUsedError;

  /// The product identifier that unlocked this entitlement
  String get productIdentifier => throw _privateConstructorUsedError;

  /// False if this entitlement is unlocked via a production purchase
  bool get isSandbox => throw _privateConstructorUsedError;

  /// Use this property to determine whether a purchase was made by the current
  /// user or shared to them by a family member. This can be useful for
  /// onboarding users who have had an entitlement shared with them, but might
  /// not be entirely aware of the benefits they now have.
  @JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
  OwnershipType get ownershipType => throw _privateConstructorUsedError;

  /// The store where this entitlement was unlocked from
  @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
  Store get store => throw _privateConstructorUsedError;

  /// The last period type this entitlement was in
  @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
  PeriodType get periodType => throw _privateConstructorUsedError;

  /// The expiration date for the entitlement, can be null for lifetime access.
  /// If the [periodType] is [PeriodType.trial],
  /// this is the trial expiration date.
  String? get expirationDate => throw _privateConstructorUsedError;

  /// The date an unsubscribe was detected. Can be null if it's still
  /// subscribed or product is not a subscription.
  /// @note: Entitlement may still be active even if user has unsubscribed.
  /// Check the [isActive] property.
  String? get unsubscribeDetectedAt => throw _privateConstructorUsedError;

  /// The date a billing issue was detected. Can be null if there is no
  /// billing issue or an issue has been resolved.
  /// @note: Entitlement may still be active even if there is a billing issue.
  /// Check the [isActive] property.
  String? get billingIssueDetectedAt => throw _privateConstructorUsedError;

  /// The base plan identifier that unlocked this entitlement (Google only).
  String? get productPlanIdentifier => throw _privateConstructorUsedError;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  VerificationResult get verification => throw _privateConstructorUsedError;

  /// Serializes this EntitlementInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntitlementInfoCopyWith<EntitlementInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntitlementInfoCopyWith<$Res> {
  factory $EntitlementInfoCopyWith(
          EntitlementInfo value, $Res Function(EntitlementInfo) then) =
      _$EntitlementInfoCopyWithImpl<$Res, EntitlementInfo>;
  @useResult
  $Res call(
      {String identifier,
      bool isActive,
      bool willRenew,
      String latestPurchaseDate,
      String originalPurchaseDate,
      String productIdentifier,
      bool isSandbox,
      @JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
      OwnershipType ownershipType,
      @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore) Store store,
      @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
      PeriodType periodType,
      String? expirationDate,
      String? unsubscribeDetectedAt,
      String? billingIssueDetectedAt,
      String? productPlanIdentifier,
      VerificationResult verification});
}

/// @nodoc
class _$EntitlementInfoCopyWithImpl<$Res, $Val extends EntitlementInfo>
    implements $EntitlementInfoCopyWith<$Res> {
  _$EntitlementInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? isActive = null,
    Object? willRenew = null,
    Object? latestPurchaseDate = null,
    Object? originalPurchaseDate = null,
    Object? productIdentifier = null,
    Object? isSandbox = null,
    Object? ownershipType = null,
    Object? store = null,
    Object? periodType = null,
    Object? expirationDate = freezed,
    Object? unsubscribeDetectedAt = freezed,
    Object? billingIssueDetectedAt = freezed,
    Object? productPlanIdentifier = freezed,
    Object? verification = null,
  }) {
    return _then(_value.copyWith(
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      willRenew: null == willRenew
          ? _value.willRenew
          : willRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      latestPurchaseDate: null == latestPurchaseDate
          ? _value.latestPurchaseDate
          : latestPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      originalPurchaseDate: null == originalPurchaseDate
          ? _value.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      productIdentifier: null == productIdentifier
          ? _value.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      isSandbox: null == isSandbox
          ? _value.isSandbox
          : isSandbox // ignore: cast_nullable_to_non_nullable
              as bool,
      ownershipType: null == ownershipType
          ? _value.ownershipType
          : ownershipType // ignore: cast_nullable_to_non_nullable
              as OwnershipType,
      store: null == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store,
      periodType: null == periodType
          ? _value.periodType
          : periodType // ignore: cast_nullable_to_non_nullable
              as PeriodType,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      unsubscribeDetectedAt: freezed == unsubscribeDetectedAt
          ? _value.unsubscribeDetectedAt
          : unsubscribeDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      billingIssueDetectedAt: freezed == billingIssueDetectedAt
          ? _value.billingIssueDetectedAt
          : billingIssueDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      productPlanIdentifier: freezed == productPlanIdentifier
          ? _value.productPlanIdentifier
          : productPlanIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntitlementInfoImplCopyWith<$Res>
    implements $EntitlementInfoCopyWith<$Res> {
  factory _$$EntitlementInfoImplCopyWith(_$EntitlementInfoImpl value,
          $Res Function(_$EntitlementInfoImpl) then) =
      __$$EntitlementInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String identifier,
      bool isActive,
      bool willRenew,
      String latestPurchaseDate,
      String originalPurchaseDate,
      String productIdentifier,
      bool isSandbox,
      @JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
      OwnershipType ownershipType,
      @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore) Store store,
      @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
      PeriodType periodType,
      String? expirationDate,
      String? unsubscribeDetectedAt,
      String? billingIssueDetectedAt,
      String? productPlanIdentifier,
      VerificationResult verification});
}

/// @nodoc
class __$$EntitlementInfoImplCopyWithImpl<$Res>
    extends _$EntitlementInfoCopyWithImpl<$Res, _$EntitlementInfoImpl>
    implements _$$EntitlementInfoImplCopyWith<$Res> {
  __$$EntitlementInfoImplCopyWithImpl(
      _$EntitlementInfoImpl _value, $Res Function(_$EntitlementInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identifier = null,
    Object? isActive = null,
    Object? willRenew = null,
    Object? latestPurchaseDate = null,
    Object? originalPurchaseDate = null,
    Object? productIdentifier = null,
    Object? isSandbox = null,
    Object? ownershipType = null,
    Object? store = null,
    Object? periodType = null,
    Object? expirationDate = freezed,
    Object? unsubscribeDetectedAt = freezed,
    Object? billingIssueDetectedAt = freezed,
    Object? productPlanIdentifier = freezed,
    Object? verification = null,
  }) {
    return _then(_$EntitlementInfoImpl(
      null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      null == willRenew
          ? _value.willRenew
          : willRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      null == latestPurchaseDate
          ? _value.latestPurchaseDate
          : latestPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      null == originalPurchaseDate
          ? _value.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      null == productIdentifier
          ? _value.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == isSandbox
          ? _value.isSandbox
          : isSandbox // ignore: cast_nullable_to_non_nullable
              as bool,
      ownershipType: null == ownershipType
          ? _value.ownershipType
          : ownershipType // ignore: cast_nullable_to_non_nullable
              as OwnershipType,
      store: null == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store,
      periodType: null == periodType
          ? _value.periodType
          : periodType // ignore: cast_nullable_to_non_nullable
              as PeriodType,
      expirationDate: freezed == expirationDate
          ? _value.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      unsubscribeDetectedAt: freezed == unsubscribeDetectedAt
          ? _value.unsubscribeDetectedAt
          : unsubscribeDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      billingIssueDetectedAt: freezed == billingIssueDetectedAt
          ? _value.billingIssueDetectedAt
          : billingIssueDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      productPlanIdentifier: freezed == productPlanIdentifier
          ? _value.productPlanIdentifier
          : productPlanIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: null == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntitlementInfoImpl implements _EntitlementInfo {
  const _$EntitlementInfoImpl(
      this.identifier,
      this.isActive,
      this.willRenew,
      this.latestPurchaseDate,
      this.originalPurchaseDate,
      this.productIdentifier,
      this.isSandbox,
      {@JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
      this.ownershipType = OwnershipType.unknown,
      @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
      this.store = Store.unknownStore,
      @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
      this.periodType = PeriodType.unknown,
      this.expirationDate,
      this.unsubscribeDetectedAt,
      this.billingIssueDetectedAt,
      this.productPlanIdentifier,
      this.verification = VerificationResult.notRequested});

  factory _$EntitlementInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntitlementInfoImplFromJson(json);

  /// The entitlement identifier configured in the RevenueCat dashboard
  @override
  final String identifier;

  /// True if the user has access to this entitlement
  @override
  final bool isActive;

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate).
  @override
  final bool willRenew;

  /// The latest purchase or renewal date for the entitlement.
  @override
  final String latestPurchaseDate;

  /// The first date this entitlement was purchased
  @override
  final String originalPurchaseDate;

  /// The product identifier that unlocked this entitlement
  @override
  final String productIdentifier;

  /// False if this entitlement is unlocked via a production purchase
  @override
  final bool isSandbox;

  /// Use this property to determine whether a purchase was made by the current
  /// user or shared to them by a family member. This can be useful for
  /// onboarding users who have had an entitlement shared with them, but might
  /// not be entirely aware of the benefits they now have.
  @override
  @JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
  final OwnershipType ownershipType;

  /// The store where this entitlement was unlocked from
  @override
  @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
  final Store store;

  /// The last period type this entitlement was in
  @override
  @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
  final PeriodType periodType;

  /// The expiration date for the entitlement, can be null for lifetime access.
  /// If the [periodType] is [PeriodType.trial],
  /// this is the trial expiration date.
  @override
  final String? expirationDate;

  /// The date an unsubscribe was detected. Can be null if it's still
  /// subscribed or product is not a subscription.
  /// @note: Entitlement may still be active even if user has unsubscribed.
  /// Check the [isActive] property.
  @override
  final String? unsubscribeDetectedAt;

  /// The date a billing issue was detected. Can be null if there is no
  /// billing issue or an issue has been resolved.
  /// @note: Entitlement may still be active even if there is a billing issue.
  /// Check the [isActive] property.
  @override
  final String? billingIssueDetectedAt;

  /// The base plan identifier that unlocked this entitlement (Google only).
  @override
  final String? productPlanIdentifier;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  @override
  @JsonKey()
  final VerificationResult verification;

  @override
  String toString() {
    return 'EntitlementInfo(identifier: $identifier, isActive: $isActive, willRenew: $willRenew, latestPurchaseDate: $latestPurchaseDate, originalPurchaseDate: $originalPurchaseDate, productIdentifier: $productIdentifier, isSandbox: $isSandbox, ownershipType: $ownershipType, store: $store, periodType: $periodType, expirationDate: $expirationDate, unsubscribeDetectedAt: $unsubscribeDetectedAt, billingIssueDetectedAt: $billingIssueDetectedAt, productPlanIdentifier: $productPlanIdentifier, verification: $verification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntitlementInfoImpl &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.willRenew, willRenew) ||
                other.willRenew == willRenew) &&
            (identical(other.latestPurchaseDate, latestPurchaseDate) ||
                other.latestPurchaseDate == latestPurchaseDate) &&
            (identical(other.originalPurchaseDate, originalPurchaseDate) ||
                other.originalPurchaseDate == originalPurchaseDate) &&
            (identical(other.productIdentifier, productIdentifier) ||
                other.productIdentifier == productIdentifier) &&
            (identical(other.isSandbox, isSandbox) ||
                other.isSandbox == isSandbox) &&
            (identical(other.ownershipType, ownershipType) ||
                other.ownershipType == ownershipType) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.periodType, periodType) ||
                other.periodType == periodType) &&
            (identical(other.expirationDate, expirationDate) ||
                other.expirationDate == expirationDate) &&
            (identical(other.unsubscribeDetectedAt, unsubscribeDetectedAt) ||
                other.unsubscribeDetectedAt == unsubscribeDetectedAt) &&
            (identical(other.billingIssueDetectedAt, billingIssueDetectedAt) ||
                other.billingIssueDetectedAt == billingIssueDetectedAt) &&
            (identical(other.productPlanIdentifier, productPlanIdentifier) ||
                other.productPlanIdentifier == productPlanIdentifier) &&
            (identical(other.verification, verification) ||
                other.verification == verification));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      identifier,
      isActive,
      willRenew,
      latestPurchaseDate,
      originalPurchaseDate,
      productIdentifier,
      isSandbox,
      ownershipType,
      store,
      periodType,
      expirationDate,
      unsubscribeDetectedAt,
      billingIssueDetectedAt,
      productPlanIdentifier,
      verification);

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntitlementInfoImplCopyWith<_$EntitlementInfoImpl> get copyWith =>
      __$$EntitlementInfoImplCopyWithImpl<_$EntitlementInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntitlementInfoImplToJson(
      this,
    );
  }
}

abstract class _EntitlementInfo implements EntitlementInfo {
  const factory _EntitlementInfo(
      final String identifier,
      final bool isActive,
      final bool willRenew,
      final String latestPurchaseDate,
      final String originalPurchaseDate,
      final String productIdentifier,
      final bool isSandbox,
      {@JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
      final OwnershipType ownershipType,
      @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
      final Store store,
      @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
      final PeriodType periodType,
      final String? expirationDate,
      final String? unsubscribeDetectedAt,
      final String? billingIssueDetectedAt,
      final String? productPlanIdentifier,
      final VerificationResult verification}) = _$EntitlementInfoImpl;

  factory _EntitlementInfo.fromJson(Map<String, dynamic> json) =
      _$EntitlementInfoImpl.fromJson;

  /// The entitlement identifier configured in the RevenueCat dashboard
  @override
  String get identifier;

  /// True if the user has access to this entitlement
  @override
  bool get isActive;

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate).
  @override
  bool get willRenew;

  /// The latest purchase or renewal date for the entitlement.
  @override
  String get latestPurchaseDate;

  /// The first date this entitlement was purchased
  @override
  String get originalPurchaseDate;

  /// The product identifier that unlocked this entitlement
  @override
  String get productIdentifier;

  /// False if this entitlement is unlocked via a production purchase
  @override
  bool get isSandbox;

  /// Use this property to determine whether a purchase was made by the current
  /// user or shared to them by a family member. This can be useful for
  /// onboarding users who have had an entitlement shared with them, but might
  /// not be entirely aware of the benefits they now have.
  @override
  @JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
  OwnershipType get ownershipType;

  /// The store where this entitlement was unlocked from
  @override
  @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
  Store get store;

  /// The last period type this entitlement was in
  @override
  @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
  PeriodType get periodType;

  /// The expiration date for the entitlement, can be null for lifetime access.
  /// If the [periodType] is [PeriodType.trial],
  /// this is the trial expiration date.
  @override
  String? get expirationDate;

  /// The date an unsubscribe was detected. Can be null if it's still
  /// subscribed or product is not a subscription.
  /// @note: Entitlement may still be active even if user has unsubscribed.
  /// Check the [isActive] property.
  @override
  String? get unsubscribeDetectedAt;

  /// The date a billing issue was detected. Can be null if there is no
  /// billing issue or an issue has been resolved.
  /// @note: Entitlement may still be active even if there is a billing issue.
  /// Check the [isActive] property.
  @override
  String? get billingIssueDetectedAt;

  /// The base plan identifier that unlocked this entitlement (Google only).
  @override
  String? get productPlanIdentifier;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  @override
  VerificationResult get verification;

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntitlementInfoImplCopyWith<_$EntitlementInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
