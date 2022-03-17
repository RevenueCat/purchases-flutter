// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'customer_info_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) {
  return _CustomerInfo.fromJson(json);
}

/// @nodoc
class _$CustomerInfoTearOff {
  const _$CustomerInfoTearOff();

  _CustomerInfo call(
      @JsonKey(name: 'entitlements')
          EntitlementInfos entitlements,
      @JsonKey(name: 'allPurchaseDates')
          Map<String, String> allPurchaseDates,
      @JsonKey(name: 'activeSubscriptions')
          List<String> activeSubscriptions,
      @JsonKey(name: 'allPurchasedProductIdentifiers')
          List<String> allPurchasedProductIdentifiers,
      @JsonKey(name: 'nonSubscriptionTransactions')
          List<StoreTransaction> nonSubscriptionTransactions,
      @JsonKey(name: 'firstSeen')
          String firstSeen,
      @JsonKey(name: 'originalAppUserId')
          String originalAppUserId,
      @JsonKey(name: 'allExpirationDates')
          Map<String, String?> allExpirationDates,
      @JsonKey(name: 'requestDate')
          String requestDate,
      {@JsonKey(name: 'latestExpirationDate', nullable: true)
          String? latestExpirationDate,
      @JsonKey(name: 'originalPurchaseDate', nullable: true)
          String? originalPurchaseDate,
      @JsonKey(name: 'originalApplicationVersion', nullable: true)
          String? originalApplicationVersion,
      @JsonKey(name: 'managementURL')
          String? managementURL}) {
    return _CustomerInfo(
      entitlements,
      allPurchaseDates,
      activeSubscriptions,
      allPurchasedProductIdentifiers,
      nonSubscriptionTransactions,
      firstSeen,
      originalAppUserId,
      allExpirationDates,
      requestDate,
      latestExpirationDate: latestExpirationDate,
      originalPurchaseDate: originalPurchaseDate,
      originalApplicationVersion: originalApplicationVersion,
      managementURL: managementURL,
    );
  }

  CustomerInfo fromJson(Map<String, Object?> json) {
    return CustomerInfo.fromJson(json);
  }
}

/// @nodoc
const $CustomerInfo = _$CustomerInfoTearOff();

/// @nodoc
mixin _$CustomerInfo {
  /// Entitlements attached to this customer info
  @JsonKey(name: 'entitlements')
  EntitlementInfos get entitlements => throw _privateConstructorUsedError;

  /// Map of skus to purchase dates
  @JsonKey(name: 'allPurchaseDates')
  Map<String, String> get allPurchaseDates =>
      throw _privateConstructorUsedError;

  /// Set of active subscription skus
  @JsonKey(name: 'activeSubscriptions')
  List<String> get activeSubscriptions => throw _privateConstructorUsedError;

  /// Set of purchased skus, active and inactive
  @JsonKey(name: 'allPurchasedProductIdentifiers')
  List<String> get allPurchasedProductIdentifiers =>
      throw _privateConstructorUsedError;

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  @JsonKey(name: 'nonSubscriptionTransactions')
  List<StoreTransaction> get nonSubscriptionTransactions =>
      throw _privateConstructorUsedError;

  /// The date this user was first seen in RevenueCat.
  @JsonKey(name: 'firstSeen')
  String get firstSeen => throw _privateConstructorUsedError;

  /// The original App User Id recorded for this user.
  @JsonKey(name: 'originalAppUserId')
  String get originalAppUserId => throw _privateConstructorUsedError;

  /// Map of skus to expiration dates
  @JsonKey(name: 'allExpirationDates')
  Map<String, String?> get allExpirationDates =>
      throw _privateConstructorUsedError;

  /// Date when this info was requested
  @JsonKey(name: 'requestDate')
  String get requestDate => throw _privateConstructorUsedError;

  /// The latest expiration date of all purchased skus
  @JsonKey(name: 'latestExpirationDate', nullable: true)
  String? get latestExpirationDate => throw _privateConstructorUsedError;

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  @JsonKey(name: 'originalPurchaseDate', nullable: true)
  String? get originalPurchaseDate => throw _privateConstructorUsedError;

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  @JsonKey(name: 'originalApplicationVersion', nullable: true)
  String? get originalApplicationVersion => throw _privateConstructorUsedError;

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
  @JsonKey(name: 'managementURL')
  String? get managementURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerInfoCopyWith<CustomerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerInfoCopyWith<$Res> {
  factory $CustomerInfoCopyWith(
          CustomerInfo value, $Res Function(CustomerInfo) then) =
      _$CustomerInfoCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'entitlements')
          EntitlementInfos entitlements,
      @JsonKey(name: 'allPurchaseDates')
          Map<String, String> allPurchaseDates,
      @JsonKey(name: 'activeSubscriptions')
          List<String> activeSubscriptions,
      @JsonKey(name: 'allPurchasedProductIdentifiers')
          List<String> allPurchasedProductIdentifiers,
      @JsonKey(name: 'nonSubscriptionTransactions')
          List<StoreTransaction> nonSubscriptionTransactions,
      @JsonKey(name: 'firstSeen')
          String firstSeen,
      @JsonKey(name: 'originalAppUserId')
          String originalAppUserId,
      @JsonKey(name: 'allExpirationDates')
          Map<String, String?> allExpirationDates,
      @JsonKey(name: 'requestDate')
          String requestDate,
      @JsonKey(name: 'latestExpirationDate', nullable: true)
          String? latestExpirationDate,
      @JsonKey(name: 'originalPurchaseDate', nullable: true)
          String? originalPurchaseDate,
      @JsonKey(name: 'originalApplicationVersion', nullable: true)
          String? originalApplicationVersion,
      @JsonKey(name: 'managementURL')
          String? managementURL});

  $EntitlementInfosCopyWith<$Res> get entitlements;
}

/// @nodoc
class _$CustomerInfoCopyWithImpl<$Res> implements $CustomerInfoCopyWith<$Res> {
  _$CustomerInfoCopyWithImpl(this._value, this._then);

  final CustomerInfo _value;
  // ignore: unused_field
  final $Res Function(CustomerInfo) _then;

  @override
  $Res call({
    Object? entitlements = freezed,
    Object? allPurchaseDates = freezed,
    Object? activeSubscriptions = freezed,
    Object? allPurchasedProductIdentifiers = freezed,
    Object? nonSubscriptionTransactions = freezed,
    Object? firstSeen = freezed,
    Object? originalAppUserId = freezed,
    Object? allExpirationDates = freezed,
    Object? requestDate = freezed,
    Object? latestExpirationDate = freezed,
    Object? originalPurchaseDate = freezed,
    Object? originalApplicationVersion = freezed,
    Object? managementURL = freezed,
  }) {
    return _then(_value.copyWith(
      entitlements: entitlements == freezed
          ? _value.entitlements
          : entitlements // ignore: cast_nullable_to_non_nullable
              as EntitlementInfos,
      allPurchaseDates: allPurchaseDates == freezed
          ? _value.allPurchaseDates
          : allPurchaseDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      activeSubscriptions: activeSubscriptions == freezed
          ? _value.activeSubscriptions
          : activeSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allPurchasedProductIdentifiers: allPurchasedProductIdentifiers == freezed
          ? _value.allPurchasedProductIdentifiers
          : allPurchasedProductIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nonSubscriptionTransactions: nonSubscriptionTransactions == freezed
          ? _value.nonSubscriptionTransactions
          : nonSubscriptionTransactions // ignore: cast_nullable_to_non_nullable
              as List<StoreTransaction>,
      firstSeen: firstSeen == freezed
          ? _value.firstSeen
          : firstSeen // ignore: cast_nullable_to_non_nullable
              as String,
      originalAppUserId: originalAppUserId == freezed
          ? _value.originalAppUserId
          : originalAppUserId // ignore: cast_nullable_to_non_nullable
              as String,
      allExpirationDates: allExpirationDates == freezed
          ? _value.allExpirationDates
          : allExpirationDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      requestDate: requestDate == freezed
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String,
      latestExpirationDate: latestExpirationDate == freezed
          ? _value.latestExpirationDate
          : latestExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalPurchaseDate: originalPurchaseDate == freezed
          ? _value.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalApplicationVersion: originalApplicationVersion == freezed
          ? _value.originalApplicationVersion
          : originalApplicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      managementURL: managementURL == freezed
          ? _value.managementURL
          : managementURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $EntitlementInfosCopyWith<$Res> get entitlements {
    return $EntitlementInfosCopyWith<$Res>(_value.entitlements, (value) {
      return _then(_value.copyWith(entitlements: value));
    });
  }
}

/// @nodoc
abstract class _$CustomerInfoCopyWith<$Res>
    implements $CustomerInfoCopyWith<$Res> {
  factory _$CustomerInfoCopyWith(
          _CustomerInfo value, $Res Function(_CustomerInfo) then) =
      __$CustomerInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'entitlements')
          EntitlementInfos entitlements,
      @JsonKey(name: 'allPurchaseDates')
          Map<String, String> allPurchaseDates,
      @JsonKey(name: 'activeSubscriptions')
          List<String> activeSubscriptions,
      @JsonKey(name: 'allPurchasedProductIdentifiers')
          List<String> allPurchasedProductIdentifiers,
      @JsonKey(name: 'nonSubscriptionTransactions')
          List<StoreTransaction> nonSubscriptionTransactions,
      @JsonKey(name: 'firstSeen')
          String firstSeen,
      @JsonKey(name: 'originalAppUserId')
          String originalAppUserId,
      @JsonKey(name: 'allExpirationDates')
          Map<String, String?> allExpirationDates,
      @JsonKey(name: 'requestDate')
          String requestDate,
      @JsonKey(name: 'latestExpirationDate', nullable: true)
          String? latestExpirationDate,
      @JsonKey(name: 'originalPurchaseDate', nullable: true)
          String? originalPurchaseDate,
      @JsonKey(name: 'originalApplicationVersion', nullable: true)
          String? originalApplicationVersion,
      @JsonKey(name: 'managementURL')
          String? managementURL});

  @override
  $EntitlementInfosCopyWith<$Res> get entitlements;
}

/// @nodoc
class __$CustomerInfoCopyWithImpl<$Res> extends _$CustomerInfoCopyWithImpl<$Res>
    implements _$CustomerInfoCopyWith<$Res> {
  __$CustomerInfoCopyWithImpl(
      _CustomerInfo _value, $Res Function(_CustomerInfo) _then)
      : super(_value, (v) => _then(v as _CustomerInfo));

  @override
  _CustomerInfo get _value => super._value as _CustomerInfo;

  @override
  $Res call({
    Object? entitlements = freezed,
    Object? allPurchaseDates = freezed,
    Object? activeSubscriptions = freezed,
    Object? allPurchasedProductIdentifiers = freezed,
    Object? nonSubscriptionTransactions = freezed,
    Object? firstSeen = freezed,
    Object? originalAppUserId = freezed,
    Object? allExpirationDates = freezed,
    Object? requestDate = freezed,
    Object? latestExpirationDate = freezed,
    Object? originalPurchaseDate = freezed,
    Object? originalApplicationVersion = freezed,
    Object? managementURL = freezed,
  }) {
    return _then(_CustomerInfo(
      entitlements == freezed
          ? _value.entitlements
          : entitlements // ignore: cast_nullable_to_non_nullable
              as EntitlementInfos,
      allPurchaseDates == freezed
          ? _value.allPurchaseDates
          : allPurchaseDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      activeSubscriptions == freezed
          ? _value.activeSubscriptions
          : activeSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allPurchasedProductIdentifiers == freezed
          ? _value.allPurchasedProductIdentifiers
          : allPurchasedProductIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nonSubscriptionTransactions == freezed
          ? _value.nonSubscriptionTransactions
          : nonSubscriptionTransactions // ignore: cast_nullable_to_non_nullable
              as List<StoreTransaction>,
      firstSeen == freezed
          ? _value.firstSeen
          : firstSeen // ignore: cast_nullable_to_non_nullable
              as String,
      originalAppUserId == freezed
          ? _value.originalAppUserId
          : originalAppUserId // ignore: cast_nullable_to_non_nullable
              as String,
      allExpirationDates == freezed
          ? _value.allExpirationDates
          : allExpirationDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      requestDate == freezed
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String,
      latestExpirationDate: latestExpirationDate == freezed
          ? _value.latestExpirationDate
          : latestExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalPurchaseDate: originalPurchaseDate == freezed
          ? _value.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalApplicationVersion: originalApplicationVersion == freezed
          ? _value.originalApplicationVersion
          : originalApplicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      managementURL: managementURL == freezed
          ? _value.managementURL
          : managementURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CustomerInfo implements _CustomerInfo {
  const _$_CustomerInfo(
      @JsonKey(name: 'entitlements')
          this.entitlements,
      @JsonKey(name: 'allPurchaseDates')
          this.allPurchaseDates,
      @JsonKey(name: 'activeSubscriptions')
          this.activeSubscriptions,
      @JsonKey(name: 'allPurchasedProductIdentifiers')
          this.allPurchasedProductIdentifiers,
      @JsonKey(name: 'nonSubscriptionTransactions')
          this.nonSubscriptionTransactions,
      @JsonKey(name: 'firstSeen')
          this.firstSeen,
      @JsonKey(name: 'originalAppUserId')
          this.originalAppUserId,
      @JsonKey(name: 'allExpirationDates')
          this.allExpirationDates,
      @JsonKey(name: 'requestDate')
          this.requestDate,
      {@JsonKey(name: 'latestExpirationDate', nullable: true)
          this.latestExpirationDate,
      @JsonKey(name: 'originalPurchaseDate', nullable: true)
          this.originalPurchaseDate,
      @JsonKey(name: 'originalApplicationVersion', nullable: true)
          this.originalApplicationVersion,
      @JsonKey(name: 'managementURL')
          this.managementURL});

  factory _$_CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$$_CustomerInfoFromJson(json);

  @override

  /// Entitlements attached to this customer info
  @JsonKey(name: 'entitlements')
  final EntitlementInfos entitlements;
  @override

  /// Map of skus to purchase dates
  @JsonKey(name: 'allPurchaseDates')
  final Map<String, String> allPurchaseDates;
  @override

  /// Set of active subscription skus
  @JsonKey(name: 'activeSubscriptions')
  final List<String> activeSubscriptions;
  @override

  /// Set of purchased skus, active and inactive
  @JsonKey(name: 'allPurchasedProductIdentifiers')
  final List<String> allPurchasedProductIdentifiers;
  @override

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  @JsonKey(name: 'nonSubscriptionTransactions')
  final List<StoreTransaction> nonSubscriptionTransactions;
  @override

  /// The date this user was first seen in RevenueCat.
  @JsonKey(name: 'firstSeen')
  final String firstSeen;
  @override

  /// The original App User Id recorded for this user.
  @JsonKey(name: 'originalAppUserId')
  final String originalAppUserId;
  @override

  /// Map of skus to expiration dates
  @JsonKey(name: 'allExpirationDates')
  final Map<String, String?> allExpirationDates;
  @override

  /// Date when this info was requested
  @JsonKey(name: 'requestDate')
  final String requestDate;
  @override

  /// The latest expiration date of all purchased skus
  @JsonKey(name: 'latestExpirationDate', nullable: true)
  final String? latestExpirationDate;
  @override

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  @JsonKey(name: 'originalPurchaseDate', nullable: true)
  final String? originalPurchaseDate;
  @override

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  @JsonKey(name: 'originalApplicationVersion', nullable: true)
  final String? originalApplicationVersion;
  @override

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
  @JsonKey(name: 'managementURL')
  final String? managementURL;

  @override
  String toString() {
    return 'CustomerInfo(entitlements: $entitlements, allPurchaseDates: $allPurchaseDates, activeSubscriptions: $activeSubscriptions, allPurchasedProductIdentifiers: $allPurchasedProductIdentifiers, nonSubscriptionTransactions: $nonSubscriptionTransactions, firstSeen: $firstSeen, originalAppUserId: $originalAppUserId, allExpirationDates: $allExpirationDates, requestDate: $requestDate, latestExpirationDate: $latestExpirationDate, originalPurchaseDate: $originalPurchaseDate, originalApplicationVersion: $originalApplicationVersion, managementURL: $managementURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerInfo &&
            const DeepCollectionEquality()
                .equals(other.entitlements, entitlements) &&
            const DeepCollectionEquality()
                .equals(other.allPurchaseDates, allPurchaseDates) &&
            const DeepCollectionEquality()
                .equals(other.activeSubscriptions, activeSubscriptions) &&
            const DeepCollectionEquality().equals(
                other.allPurchasedProductIdentifiers,
                allPurchasedProductIdentifiers) &&
            const DeepCollectionEquality().equals(
                other.nonSubscriptionTransactions,
                nonSubscriptionTransactions) &&
            const DeepCollectionEquality().equals(other.firstSeen, firstSeen) &&
            const DeepCollectionEquality()
                .equals(other.originalAppUserId, originalAppUserId) &&
            const DeepCollectionEquality()
                .equals(other.allExpirationDates, allExpirationDates) &&
            const DeepCollectionEquality()
                .equals(other.requestDate, requestDate) &&
            const DeepCollectionEquality()
                .equals(other.latestExpirationDate, latestExpirationDate) &&
            const DeepCollectionEquality()
                .equals(other.originalPurchaseDate, originalPurchaseDate) &&
            const DeepCollectionEquality().equals(
                other.originalApplicationVersion, originalApplicationVersion) &&
            const DeepCollectionEquality()
                .equals(other.managementURL, managementURL));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(entitlements),
      const DeepCollectionEquality().hash(allPurchaseDates),
      const DeepCollectionEquality().hash(activeSubscriptions),
      const DeepCollectionEquality().hash(allPurchasedProductIdentifiers),
      const DeepCollectionEquality().hash(nonSubscriptionTransactions),
      const DeepCollectionEquality().hash(firstSeen),
      const DeepCollectionEquality().hash(originalAppUserId),
      const DeepCollectionEquality().hash(allExpirationDates),
      const DeepCollectionEquality().hash(requestDate),
      const DeepCollectionEquality().hash(latestExpirationDate),
      const DeepCollectionEquality().hash(originalPurchaseDate),
      const DeepCollectionEquality().hash(originalApplicationVersion),
      const DeepCollectionEquality().hash(managementURL));

  @JsonKey(ignore: true)
  @override
  _$CustomerInfoCopyWith<_CustomerInfo> get copyWith =>
      __$CustomerInfoCopyWithImpl<_CustomerInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CustomerInfoToJson(this);
  }
}

abstract class _CustomerInfo implements CustomerInfo {
  const factory _CustomerInfo(
      @JsonKey(name: 'entitlements')
          EntitlementInfos entitlements,
      @JsonKey(name: 'allPurchaseDates')
          Map<String, String> allPurchaseDates,
      @JsonKey(name: 'activeSubscriptions')
          List<String> activeSubscriptions,
      @JsonKey(name: 'allPurchasedProductIdentifiers')
          List<String> allPurchasedProductIdentifiers,
      @JsonKey(name: 'nonSubscriptionTransactions')
          List<StoreTransaction> nonSubscriptionTransactions,
      @JsonKey(name: 'firstSeen')
          String firstSeen,
      @JsonKey(name: 'originalAppUserId')
          String originalAppUserId,
      @JsonKey(name: 'allExpirationDates')
          Map<String, String?> allExpirationDates,
      @JsonKey(name: 'requestDate')
          String requestDate,
      {@JsonKey(name: 'latestExpirationDate', nullable: true)
          String? latestExpirationDate,
      @JsonKey(name: 'originalPurchaseDate', nullable: true)
          String? originalPurchaseDate,
      @JsonKey(name: 'originalApplicationVersion', nullable: true)
          String? originalApplicationVersion,
      @JsonKey(name: 'managementURL')
          String? managementURL}) = _$_CustomerInfo;

  factory _CustomerInfo.fromJson(Map<String, dynamic> json) =
      _$_CustomerInfo.fromJson;

  @override

  /// Entitlements attached to this customer info
  @JsonKey(name: 'entitlements')
  EntitlementInfos get entitlements;
  @override

  /// Map of skus to purchase dates
  @JsonKey(name: 'allPurchaseDates')
  Map<String, String> get allPurchaseDates;
  @override

  /// Set of active subscription skus
  @JsonKey(name: 'activeSubscriptions')
  List<String> get activeSubscriptions;
  @override

  /// Set of purchased skus, active and inactive
  @JsonKey(name: 'allPurchasedProductIdentifiers')
  List<String> get allPurchasedProductIdentifiers;
  @override

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  @JsonKey(name: 'nonSubscriptionTransactions')
  List<StoreTransaction> get nonSubscriptionTransactions;
  @override

  /// The date this user was first seen in RevenueCat.
  @JsonKey(name: 'firstSeen')
  String get firstSeen;
  @override

  /// The original App User Id recorded for this user.
  @JsonKey(name: 'originalAppUserId')
  String get originalAppUserId;
  @override

  /// Map of skus to expiration dates
  @JsonKey(name: 'allExpirationDates')
  Map<String, String?> get allExpirationDates;
  @override

  /// Date when this info was requested
  @JsonKey(name: 'requestDate')
  String get requestDate;
  @override

  /// The latest expiration date of all purchased skus
  @JsonKey(name: 'latestExpirationDate', nullable: true)
  String? get latestExpirationDate;
  @override

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  @JsonKey(name: 'originalPurchaseDate', nullable: true)
  String? get originalPurchaseDate;
  @override

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  @JsonKey(name: 'originalApplicationVersion', nullable: true)
  String? get originalApplicationVersion;
  @override

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
  @JsonKey(name: 'managementURL')
  String? get managementURL;
  @override
  @JsonKey(ignore: true)
  _$CustomerInfoCopyWith<_CustomerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
