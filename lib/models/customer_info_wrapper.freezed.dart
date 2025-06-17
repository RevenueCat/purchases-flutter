// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_info_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerInfo {
  /// Entitlements attached to this customer info
  EntitlementInfos get entitlements;

  /// Map of skus to purchase dates
  Map<String, String?> get allPurchaseDates;

  /// Set of active subscription skus
  List<String> get activeSubscriptions;

  /// Set of purchased skus, active and inactive
  List<String> get allPurchasedProductIdentifiers;

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  List<StoreTransaction> get nonSubscriptionTransactions;

  /// The date this user was first seen in RevenueCat.
  String get firstSeen;

  /// The original App User Id recorded for this user.
  String get originalAppUserId;

  /// Map of skus to expiration dates
  Map<String, String?> get allExpirationDates;

  /// Date when this info was requested
  String get requestDate;

  /// The latest expiration date of all purchased skus
  String? get latestExpirationDate;

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  String? get originalPurchaseDate;

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  String? get originalApplicationVersion;

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
  String? get managementURL;

  /// Create a copy of CustomerInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomerInfoCopyWith<CustomerInfo> get copyWith =>
      _$CustomerInfoCopyWithImpl<CustomerInfo>(
          this as CustomerInfo, _$identity);

  /// Serializes this CustomerInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomerInfo &&
            (identical(other.entitlements, entitlements) ||
                other.entitlements == entitlements) &&
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
            (identical(other.firstSeen, firstSeen) ||
                other.firstSeen == firstSeen) &&
            (identical(other.originalAppUserId, originalAppUserId) ||
                other.originalAppUserId == originalAppUserId) &&
            const DeepCollectionEquality()
                .equals(other.allExpirationDates, allExpirationDates) &&
            (identical(other.requestDate, requestDate) ||
                other.requestDate == requestDate) &&
            (identical(other.latestExpirationDate, latestExpirationDate) ||
                other.latestExpirationDate == latestExpirationDate) &&
            (identical(other.originalPurchaseDate, originalPurchaseDate) ||
                other.originalPurchaseDate == originalPurchaseDate) &&
            (identical(other.originalApplicationVersion,
                    originalApplicationVersion) ||
                other.originalApplicationVersion ==
                    originalApplicationVersion) &&
            (identical(other.managementURL, managementURL) ||
                other.managementURL == managementURL));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      entitlements,
      const DeepCollectionEquality().hash(allPurchaseDates),
      const DeepCollectionEquality().hash(activeSubscriptions),
      const DeepCollectionEquality().hash(allPurchasedProductIdentifiers),
      const DeepCollectionEquality().hash(nonSubscriptionTransactions),
      firstSeen,
      originalAppUserId,
      const DeepCollectionEquality().hash(allExpirationDates),
      requestDate,
      latestExpirationDate,
      originalPurchaseDate,
      originalApplicationVersion,
      managementURL);

  @override
  String toString() {
    return 'CustomerInfo(entitlements: $entitlements, allPurchaseDates: $allPurchaseDates, activeSubscriptions: $activeSubscriptions, allPurchasedProductIdentifiers: $allPurchasedProductIdentifiers, nonSubscriptionTransactions: $nonSubscriptionTransactions, firstSeen: $firstSeen, originalAppUserId: $originalAppUserId, allExpirationDates: $allExpirationDates, requestDate: $requestDate, latestExpirationDate: $latestExpirationDate, originalPurchaseDate: $originalPurchaseDate, originalApplicationVersion: $originalApplicationVersion, managementURL: $managementURL)';
  }
}

/// @nodoc
abstract mixin class $CustomerInfoCopyWith<$Res> {
  factory $CustomerInfoCopyWith(
          CustomerInfo value, $Res Function(CustomerInfo) _then) =
      _$CustomerInfoCopyWithImpl;
  @useResult
  $Res call(
      {EntitlementInfos entitlements,
      Map<String, String?> allPurchaseDates,
      List<String> activeSubscriptions,
      List<String> allPurchasedProductIdentifiers,
      List<StoreTransaction> nonSubscriptionTransactions,
      String firstSeen,
      String originalAppUserId,
      Map<String, String?> allExpirationDates,
      String requestDate,
      String? latestExpirationDate,
      String? originalPurchaseDate,
      String? originalApplicationVersion,
      String? managementURL});

  $EntitlementInfosCopyWith<$Res> get entitlements;
}

/// @nodoc
class _$CustomerInfoCopyWithImpl<$Res> implements $CustomerInfoCopyWith<$Res> {
  _$CustomerInfoCopyWithImpl(this._self, this._then);

  final CustomerInfo _self;
  final $Res Function(CustomerInfo) _then;

  /// Create a copy of CustomerInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entitlements = null,
    Object? allPurchaseDates = null,
    Object? activeSubscriptions = null,
    Object? allPurchasedProductIdentifiers = null,
    Object? nonSubscriptionTransactions = null,
    Object? firstSeen = null,
    Object? originalAppUserId = null,
    Object? allExpirationDates = null,
    Object? requestDate = null,
    Object? latestExpirationDate = freezed,
    Object? originalPurchaseDate = freezed,
    Object? originalApplicationVersion = freezed,
    Object? managementURL = freezed,
  }) {
    return _then(_self.copyWith(
      entitlements: null == entitlements
          ? _self.entitlements
          : entitlements // ignore: cast_nullable_to_non_nullable
              as EntitlementInfos,
      allPurchaseDates: null == allPurchaseDates
          ? _self.allPurchaseDates
          : allPurchaseDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      activeSubscriptions: null == activeSubscriptions
          ? _self.activeSubscriptions
          : activeSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allPurchasedProductIdentifiers: null == allPurchasedProductIdentifiers
          ? _self.allPurchasedProductIdentifiers
          : allPurchasedProductIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nonSubscriptionTransactions: null == nonSubscriptionTransactions
          ? _self.nonSubscriptionTransactions
          : nonSubscriptionTransactions // ignore: cast_nullable_to_non_nullable
              as List<StoreTransaction>,
      firstSeen: null == firstSeen
          ? _self.firstSeen
          : firstSeen // ignore: cast_nullable_to_non_nullable
              as String,
      originalAppUserId: null == originalAppUserId
          ? _self.originalAppUserId
          : originalAppUserId // ignore: cast_nullable_to_non_nullable
              as String,
      allExpirationDates: null == allExpirationDates
          ? _self.allExpirationDates
          : allExpirationDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      requestDate: null == requestDate
          ? _self.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String,
      latestExpirationDate: freezed == latestExpirationDate
          ? _self.latestExpirationDate
          : latestExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalPurchaseDate: freezed == originalPurchaseDate
          ? _self.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalApplicationVersion: freezed == originalApplicationVersion
          ? _self.originalApplicationVersion
          : originalApplicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      managementURL: freezed == managementURL
          ? _self.managementURL
          : managementURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of CustomerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EntitlementInfosCopyWith<$Res> get entitlements {
    return $EntitlementInfosCopyWith<$Res>(_self.entitlements, (value) {
      return _then(_self.copyWith(entitlements: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _CustomerInfo implements CustomerInfo {
  const _CustomerInfo(
      this.entitlements,
      final Map<String, String?> allPurchaseDates,
      final List<String> activeSubscriptions,
      final List<String> allPurchasedProductIdentifiers,
      final List<StoreTransaction> nonSubscriptionTransactions,
      this.firstSeen,
      this.originalAppUserId,
      final Map<String, String?> allExpirationDates,
      this.requestDate,
      {this.latestExpirationDate,
      this.originalPurchaseDate,
      this.originalApplicationVersion,
      this.managementURL})
      : _allPurchaseDates = allPurchaseDates,
        _activeSubscriptions = activeSubscriptions,
        _allPurchasedProductIdentifiers = allPurchasedProductIdentifiers,
        _nonSubscriptionTransactions = nonSubscriptionTransactions,
        _allExpirationDates = allExpirationDates;
  factory _CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);

  /// Entitlements attached to this customer info
  @override
  final EntitlementInfos entitlements;

  /// Map of skus to purchase dates
  final Map<String, String?> _allPurchaseDates;

  /// Map of skus to purchase dates
  @override
  Map<String, String?> get allPurchaseDates {
    if (_allPurchaseDates is EqualUnmodifiableMapView) return _allPurchaseDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_allPurchaseDates);
  }

  /// Set of active subscription skus
  final List<String> _activeSubscriptions;

  /// Set of active subscription skus
  @override
  List<String> get activeSubscriptions {
    if (_activeSubscriptions is EqualUnmodifiableListView)
      return _activeSubscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeSubscriptions);
  }

  /// Set of purchased skus, active and inactive
  final List<String> _allPurchasedProductIdentifiers;

  /// Set of purchased skus, active and inactive
  @override
  List<String> get allPurchasedProductIdentifiers {
    if (_allPurchasedProductIdentifiers is EqualUnmodifiableListView)
      return _allPurchasedProductIdentifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allPurchasedProductIdentifiers);
  }

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  final List<StoreTransaction> _nonSubscriptionTransactions;

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  @override
  List<StoreTransaction> get nonSubscriptionTransactions {
    if (_nonSubscriptionTransactions is EqualUnmodifiableListView)
      return _nonSubscriptionTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nonSubscriptionTransactions);
  }

  /// The date this user was first seen in RevenueCat.
  @override
  final String firstSeen;

  /// The original App User Id recorded for this user.
  @override
  final String originalAppUserId;

  /// Map of skus to expiration dates
  final Map<String, String?> _allExpirationDates;

  /// Map of skus to expiration dates
  @override
  Map<String, String?> get allExpirationDates {
    if (_allExpirationDates is EqualUnmodifiableMapView)
      return _allExpirationDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_allExpirationDates);
  }

  /// Date when this info was requested
  @override
  final String requestDate;

  /// The latest expiration date of all purchased skus
  @override
  final String? latestExpirationDate;

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  @override
  final String? originalPurchaseDate;

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  @override
  final String? originalApplicationVersion;

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
  @override
  final String? managementURL;

  /// Create a copy of CustomerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomerInfoCopyWith<_CustomerInfo> get copyWith =>
      __$CustomerInfoCopyWithImpl<_CustomerInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomerInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomerInfo &&
            (identical(other.entitlements, entitlements) ||
                other.entitlements == entitlements) &&
            const DeepCollectionEquality()
                .equals(other._allPurchaseDates, _allPurchaseDates) &&
            const DeepCollectionEquality()
                .equals(other._activeSubscriptions, _activeSubscriptions) &&
            const DeepCollectionEquality().equals(
                other._allPurchasedProductIdentifiers,
                _allPurchasedProductIdentifiers) &&
            const DeepCollectionEquality().equals(
                other._nonSubscriptionTransactions,
                _nonSubscriptionTransactions) &&
            (identical(other.firstSeen, firstSeen) ||
                other.firstSeen == firstSeen) &&
            (identical(other.originalAppUserId, originalAppUserId) ||
                other.originalAppUserId == originalAppUserId) &&
            const DeepCollectionEquality()
                .equals(other._allExpirationDates, _allExpirationDates) &&
            (identical(other.requestDate, requestDate) ||
                other.requestDate == requestDate) &&
            (identical(other.latestExpirationDate, latestExpirationDate) ||
                other.latestExpirationDate == latestExpirationDate) &&
            (identical(other.originalPurchaseDate, originalPurchaseDate) ||
                other.originalPurchaseDate == originalPurchaseDate) &&
            (identical(other.originalApplicationVersion,
                    originalApplicationVersion) ||
                other.originalApplicationVersion ==
                    originalApplicationVersion) &&
            (identical(other.managementURL, managementURL) ||
                other.managementURL == managementURL));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      entitlements,
      const DeepCollectionEquality().hash(_allPurchaseDates),
      const DeepCollectionEquality().hash(_activeSubscriptions),
      const DeepCollectionEquality().hash(_allPurchasedProductIdentifiers),
      const DeepCollectionEquality().hash(_nonSubscriptionTransactions),
      firstSeen,
      originalAppUserId,
      const DeepCollectionEquality().hash(_allExpirationDates),
      requestDate,
      latestExpirationDate,
      originalPurchaseDate,
      originalApplicationVersion,
      managementURL);

  @override
  String toString() {
    return 'CustomerInfo(entitlements: $entitlements, allPurchaseDates: $allPurchaseDates, activeSubscriptions: $activeSubscriptions, allPurchasedProductIdentifiers: $allPurchasedProductIdentifiers, nonSubscriptionTransactions: $nonSubscriptionTransactions, firstSeen: $firstSeen, originalAppUserId: $originalAppUserId, allExpirationDates: $allExpirationDates, requestDate: $requestDate, latestExpirationDate: $latestExpirationDate, originalPurchaseDate: $originalPurchaseDate, originalApplicationVersion: $originalApplicationVersion, managementURL: $managementURL)';
  }
}

/// @nodoc
abstract mixin class _$CustomerInfoCopyWith<$Res>
    implements $CustomerInfoCopyWith<$Res> {
  factory _$CustomerInfoCopyWith(
          _CustomerInfo value, $Res Function(_CustomerInfo) _then) =
      __$CustomerInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {EntitlementInfos entitlements,
      Map<String, String?> allPurchaseDates,
      List<String> activeSubscriptions,
      List<String> allPurchasedProductIdentifiers,
      List<StoreTransaction> nonSubscriptionTransactions,
      String firstSeen,
      String originalAppUserId,
      Map<String, String?> allExpirationDates,
      String requestDate,
      String? latestExpirationDate,
      String? originalPurchaseDate,
      String? originalApplicationVersion,
      String? managementURL});

  @override
  $EntitlementInfosCopyWith<$Res> get entitlements;
}

/// @nodoc
class __$CustomerInfoCopyWithImpl<$Res>
    implements _$CustomerInfoCopyWith<$Res> {
  __$CustomerInfoCopyWithImpl(this._self, this._then);

  final _CustomerInfo _self;
  final $Res Function(_CustomerInfo) _then;

  /// Create a copy of CustomerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? entitlements = null,
    Object? allPurchaseDates = null,
    Object? activeSubscriptions = null,
    Object? allPurchasedProductIdentifiers = null,
    Object? nonSubscriptionTransactions = null,
    Object? firstSeen = null,
    Object? originalAppUserId = null,
    Object? allExpirationDates = null,
    Object? requestDate = null,
    Object? latestExpirationDate = freezed,
    Object? originalPurchaseDate = freezed,
    Object? originalApplicationVersion = freezed,
    Object? managementURL = freezed,
  }) {
    return _then(_CustomerInfo(
      null == entitlements
          ? _self.entitlements
          : entitlements // ignore: cast_nullable_to_non_nullable
              as EntitlementInfos,
      null == allPurchaseDates
          ? _self._allPurchaseDates
          : allPurchaseDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      null == activeSubscriptions
          ? _self._activeSubscriptions
          : activeSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == allPurchasedProductIdentifiers
          ? _self._allPurchasedProductIdentifiers
          : allPurchasedProductIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == nonSubscriptionTransactions
          ? _self._nonSubscriptionTransactions
          : nonSubscriptionTransactions // ignore: cast_nullable_to_non_nullable
              as List<StoreTransaction>,
      null == firstSeen
          ? _self.firstSeen
          : firstSeen // ignore: cast_nullable_to_non_nullable
              as String,
      null == originalAppUserId
          ? _self.originalAppUserId
          : originalAppUserId // ignore: cast_nullable_to_non_nullable
              as String,
      null == allExpirationDates
          ? _self._allExpirationDates
          : allExpirationDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      null == requestDate
          ? _self.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String,
      latestExpirationDate: freezed == latestExpirationDate
          ? _self.latestExpirationDate
          : latestExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalPurchaseDate: freezed == originalPurchaseDate
          ? _self.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalApplicationVersion: freezed == originalApplicationVersion
          ? _self.originalApplicationVersion
          : originalApplicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      managementURL: freezed == managementURL
          ? _self.managementURL
          : managementURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of CustomerInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EntitlementInfosCopyWith<$Res> get entitlements {
    return $EntitlementInfosCopyWith<$Res>(_self.entitlements, (value) {
      return _then(_self.copyWith(entitlements: value));
    });
  }
}

// dart format on
