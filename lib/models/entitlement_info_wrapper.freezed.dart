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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      String? billingIssueDetectedAt});
}

/// @nodoc
class _$EntitlementInfoCopyWithImpl<$Res, $Val extends EntitlementInfo>
    implements $EntitlementInfoCopyWith<$Res> {
  _$EntitlementInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EntitlementInfoCopyWith<$Res>
    implements $EntitlementInfoCopyWith<$Res> {
  factory _$$_EntitlementInfoCopyWith(
          _$_EntitlementInfo value, $Res Function(_$_EntitlementInfo) then) =
      __$$_EntitlementInfoCopyWithImpl<$Res>;
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
      String? billingIssueDetectedAt});
}

/// @nodoc
class __$$_EntitlementInfoCopyWithImpl<$Res>
    extends _$EntitlementInfoCopyWithImpl<$Res, _$_EntitlementInfo>
    implements _$$_EntitlementInfoCopyWith<$Res> {
  __$$_EntitlementInfoCopyWithImpl(
      _$_EntitlementInfo _value, $Res Function(_$_EntitlementInfo) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$_EntitlementInfo(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EntitlementInfo implements _EntitlementInfo {
  const _$_EntitlementInfo(
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
      this.billingIssueDetectedAt});

  factory _$_EntitlementInfo.fromJson(Map<String, dynamic> json) =>
      _$$_EntitlementInfoFromJson(json);

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

  @override
  String toString() {
    return 'EntitlementInfo(identifier: $identifier, isActive: $isActive, willRenew: $willRenew, latestPurchaseDate: $latestPurchaseDate, originalPurchaseDate: $originalPurchaseDate, productIdentifier: $productIdentifier, isSandbox: $isSandbox, ownershipType: $ownershipType, store: $store, periodType: $periodType, expirationDate: $expirationDate, unsubscribeDetectedAt: $unsubscribeDetectedAt, billingIssueDetectedAt: $billingIssueDetectedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EntitlementInfo &&
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
                other.billingIssueDetectedAt == billingIssueDetectedAt));
  }

  @JsonKey(ignore: true)
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
      billingIssueDetectedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EntitlementInfoCopyWith<_$_EntitlementInfo> get copyWith =>
      __$$_EntitlementInfoCopyWithImpl<_$_EntitlementInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EntitlementInfoToJson(
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
      final String? billingIssueDetectedAt}) = _$_EntitlementInfo;

  factory _EntitlementInfo.fromJson(Map<String, dynamic> json) =
      _$_EntitlementInfo.fromJson;

  @override

  /// The entitlement identifier configured in the RevenueCat dashboard
  String get identifier;
  @override

  /// True if the user has access to this entitlement
  bool get isActive;
  @override

  /// True if the underlying subscription is set to renew at the end of
  /// the billing period (expirationDate).
  bool get willRenew;
  @override

  /// The latest purchase or renewal date for the entitlement.
  String get latestPurchaseDate;
  @override

  /// The first date this entitlement was purchased
  String get originalPurchaseDate;
  @override

  /// The product identifier that unlocked this entitlement
  String get productIdentifier;
  @override

  /// False if this entitlement is unlocked via a production purchase
  bool get isSandbox;
  @override

  /// Use this property to determine whether a purchase was made by the current
  /// user or shared to them by a family member. This can be useful for
  /// onboarding users who have had an entitlement shared with them, but might
  /// not be entirely aware of the benefits they now have.
  @JsonKey(name: 'ownershipType', unknownEnumValue: OwnershipType.unknown)
  OwnershipType get ownershipType;
  @override

  /// The store where this entitlement was unlocked from
  @JsonKey(name: 'store', unknownEnumValue: Store.unknownStore)
  Store get store;
  @override

  /// The last period type this entitlement was in
  @JsonKey(name: 'periodType', unknownEnumValue: PeriodType.unknown)
  PeriodType get periodType;
  @override

  /// The expiration date for the entitlement, can be null for lifetime access.
  /// If the [periodType] is [PeriodType.trial],
  /// this is the trial expiration date.
  String? get expirationDate;
  @override

  /// The date an unsubscribe was detected. Can be null if it's still
  /// subscribed or product is not a subscription.
  /// @note: Entitlement may still be active even if user has unsubscribed.
  /// Check the [isActive] property.
  String? get unsubscribeDetectedAt;
  @override

  /// The date a billing issue was detected. Can be null if there is no
  /// billing issue or an issue has been resolved.
  /// @note: Entitlement may still be active even if there is a billing issue.
  /// Check the [isActive] property.
  String? get billingIssueDetectedAt;
  @override
  @JsonKey(ignore: true)
  _$$_EntitlementInfoCopyWith<_$_EntitlementInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
