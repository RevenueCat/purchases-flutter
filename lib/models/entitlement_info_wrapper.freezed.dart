// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement_info_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EntitlementInfo {
  /// The entitlement identifier configured in the RevenueCat dashboard
  String get identifier;

  /// True if the user has access to this entitlement
  bool get isActive;

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate).
  bool get willRenew;

  /// The latest purchase or renewal date for the entitlement.
  String get latestPurchaseDate;

  /// The first date this entitlement was purchased
  String get originalPurchaseDate;

  /// The product identifier that unlocked this entitlement
  String get productIdentifier;

  /// False if this entitlement is unlocked via a production purchase
  bool get isSandbox;

  /// Use this property to determine whether a purchase was made by the current
  /// user or shared to them by a family member. This can be useful for
  /// onboarding users who have had an entitlement shared with them, but might
  /// not be entirely aware of the benefits they now have.
  @JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
  OwnershipType get ownershipType;

  /// The store where this entitlement was unlocked from
  @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
  Store get store;

  /// The last period type this entitlement was in
  @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
  PeriodType get periodType;

  /// The expiration date for the entitlement, can be null for lifetime access.
  /// If the [periodType] is [PeriodType.trial],
  /// this is the trial expiration date.
  String? get expirationDate;

  /// The date an unsubscribe was detected. Can be null if it's still
  /// subscribed or product is not a subscription.
  /// @note: Entitlement may still be active even if user has unsubscribed.
  /// Check the [isActive] property.
  String? get unsubscribeDetectedAt;

  /// The date a billing issue was detected. Can be null if there is no
  /// billing issue or an issue has been resolved.
  /// @note: Entitlement may still be active even if there is a billing issue.
  /// Check the [isActive] property.
  String? get billingIssueDetectedAt;

  /// The base plan identifier that unlocked this entitlement (Google only).
  String? get productPlanIdentifier;

  /// If entitlement verification was enabled, the result of that verification.
  /// If not, `VerificationResult.NOT_REQUESTED`.
  VerificationResult get verification;

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EntitlementInfoCopyWith<EntitlementInfo> get copyWith =>
      _$EntitlementInfoCopyWithImpl<EntitlementInfo>(
          this as EntitlementInfo, _$identity);

  /// Serializes this EntitlementInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EntitlementInfo &&
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

  @override
  String toString() {
    return 'EntitlementInfo(identifier: $identifier, isActive: $isActive, willRenew: $willRenew, latestPurchaseDate: $latestPurchaseDate, originalPurchaseDate: $originalPurchaseDate, productIdentifier: $productIdentifier, isSandbox: $isSandbox, ownershipType: $ownershipType, store: $store, periodType: $periodType, expirationDate: $expirationDate, unsubscribeDetectedAt: $unsubscribeDetectedAt, billingIssueDetectedAt: $billingIssueDetectedAt, productPlanIdentifier: $productPlanIdentifier, verification: $verification)';
  }
}

/// @nodoc
abstract mixin class $EntitlementInfoCopyWith<$Res> {
  factory $EntitlementInfoCopyWith(
          EntitlementInfo value, $Res Function(EntitlementInfo) _then) =
      _$EntitlementInfoCopyWithImpl;
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
class _$EntitlementInfoCopyWithImpl<$Res>
    implements $EntitlementInfoCopyWith<$Res> {
  _$EntitlementInfoCopyWithImpl(this._self, this._then);

  final EntitlementInfo _self;
  final $Res Function(EntitlementInfo) _then;

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
    return _then(_self.copyWith(
      identifier: null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      willRenew: null == willRenew
          ? _self.willRenew
          : willRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      latestPurchaseDate: null == latestPurchaseDate
          ? _self.latestPurchaseDate
          : latestPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      originalPurchaseDate: null == originalPurchaseDate
          ? _self.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      productIdentifier: null == productIdentifier
          ? _self.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      isSandbox: null == isSandbox
          ? _self.isSandbox
          : isSandbox // ignore: cast_nullable_to_non_nullable
              as bool,
      ownershipType: null == ownershipType
          ? _self.ownershipType
          : ownershipType // ignore: cast_nullable_to_non_nullable
              as OwnershipType,
      store: null == store
          ? _self.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store,
      periodType: null == periodType
          ? _self.periodType
          : periodType // ignore: cast_nullable_to_non_nullable
              as PeriodType,
      expirationDate: freezed == expirationDate
          ? _self.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      unsubscribeDetectedAt: freezed == unsubscribeDetectedAt
          ? _self.unsubscribeDetectedAt
          : unsubscribeDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      billingIssueDetectedAt: freezed == billingIssueDetectedAt
          ? _self.billingIssueDetectedAt
          : billingIssueDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      productPlanIdentifier: freezed == productPlanIdentifier
          ? _self.productPlanIdentifier
          : productPlanIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: null == verification
          ? _self.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _EntitlementInfo implements EntitlementInfo {
  const _EntitlementInfo(
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
  factory _EntitlementInfo.fromJson(Map<String, dynamic> json) =>
      _$EntitlementInfoFromJson(json);

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

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EntitlementInfoCopyWith<_EntitlementInfo> get copyWith =>
      __$EntitlementInfoCopyWithImpl<_EntitlementInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EntitlementInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EntitlementInfo &&
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

  @override
  String toString() {
    return 'EntitlementInfo(identifier: $identifier, isActive: $isActive, willRenew: $willRenew, latestPurchaseDate: $latestPurchaseDate, originalPurchaseDate: $originalPurchaseDate, productIdentifier: $productIdentifier, isSandbox: $isSandbox, ownershipType: $ownershipType, store: $store, periodType: $periodType, expirationDate: $expirationDate, unsubscribeDetectedAt: $unsubscribeDetectedAt, billingIssueDetectedAt: $billingIssueDetectedAt, productPlanIdentifier: $productPlanIdentifier, verification: $verification)';
  }
}

/// @nodoc
abstract mixin class _$EntitlementInfoCopyWith<$Res>
    implements $EntitlementInfoCopyWith<$Res> {
  factory _$EntitlementInfoCopyWith(
          _EntitlementInfo value, $Res Function(_EntitlementInfo) _then) =
      __$EntitlementInfoCopyWithImpl;
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
class __$EntitlementInfoCopyWithImpl<$Res>
    implements _$EntitlementInfoCopyWith<$Res> {
  __$EntitlementInfoCopyWithImpl(this._self, this._then);

  final _EntitlementInfo _self;
  final $Res Function(_EntitlementInfo) _then;

  /// Create a copy of EntitlementInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_EntitlementInfo(
      null == identifier
          ? _self.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      null == willRenew
          ? _self.willRenew
          : willRenew // ignore: cast_nullable_to_non_nullable
              as bool,
      null == latestPurchaseDate
          ? _self.latestPurchaseDate
          : latestPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      null == originalPurchaseDate
          ? _self.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
      null == productIdentifier
          ? _self.productIdentifier
          : productIdentifier // ignore: cast_nullable_to_non_nullable
              as String,
      null == isSandbox
          ? _self.isSandbox
          : isSandbox // ignore: cast_nullable_to_non_nullable
              as bool,
      ownershipType: null == ownershipType
          ? _self.ownershipType
          : ownershipType // ignore: cast_nullable_to_non_nullable
              as OwnershipType,
      store: null == store
          ? _self.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store,
      periodType: null == periodType
          ? _self.periodType
          : periodType // ignore: cast_nullable_to_non_nullable
              as PeriodType,
      expirationDate: freezed == expirationDate
          ? _self.expirationDate
          : expirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      unsubscribeDetectedAt: freezed == unsubscribeDetectedAt
          ? _self.unsubscribeDetectedAt
          : unsubscribeDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      billingIssueDetectedAt: freezed == billingIssueDetectedAt
          ? _self.billingIssueDetectedAt
          : billingIssueDetectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      productPlanIdentifier: freezed == productPlanIdentifier
          ? _self.productPlanIdentifier
          : productPlanIdentifier // ignore: cast_nullable_to_non_nullable
              as String?,
      verification: null == verification
          ? _self.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as VerificationResult,
    ));
  }
}

// dart format on
