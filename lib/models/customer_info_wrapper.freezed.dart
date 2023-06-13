// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_info_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) {
  return _CustomerInfo.fromJson(json);
}

/// @nodoc
mixin _$CustomerInfo {
  /// Entitlements attached to this customer info
  EntitlementInfos get entitlements => throw _privateConstructorUsedError;

  /// Map of skus to purchase dates
  Map<String, String> get allPurchaseDates =>
      throw _privateConstructorUsedError;

  /// Set of active subscription skus
  List<String> get activeSubscriptions => throw _privateConstructorUsedError;

  /// Set of purchased skus, active and inactive
  List<String> get allPurchasedProductIdentifiers =>
      throw _privateConstructorUsedError;

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  List<StoreTransaction> get nonSubscriptionTransactions =>
      throw _privateConstructorUsedError;

  /// The date this user was first seen in RevenueCat.
  String get firstSeen => throw _privateConstructorUsedError;

  /// The original App User Id recorded for this user.
  String get originalAppUserId => throw _privateConstructorUsedError;

  /// Map of skus to expiration dates
  Map<String, String?> get allExpirationDates =>
      throw _privateConstructorUsedError;

  /// Date when this info was requested
  String get requestDate => throw _privateConstructorUsedError;

  /// The latest expiration date of all purchased skus
  String? get latestExpirationDate => throw _privateConstructorUsedError;

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  String? get originalPurchaseDate => throw _privateConstructorUsedError;

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  String? get originalApplicationVersion => throw _privateConstructorUsedError;

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
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
      _$CustomerInfoCopyWithImpl<$Res, CustomerInfo>;
  @useResult
  $Res call(
      {EntitlementInfos entitlements,
      Map<String, String> allPurchaseDates,
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
class _$CustomerInfoCopyWithImpl<$Res, $Val extends CustomerInfo>
    implements $CustomerInfoCopyWith<$Res> {
  _$CustomerInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      entitlements: null == entitlements
          ? _value.entitlements
          : entitlements // ignore: cast_nullable_to_non_nullable
              as EntitlementInfos,
      allPurchaseDates: null == allPurchaseDates
          ? _value.allPurchaseDates
          : allPurchaseDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      activeSubscriptions: null == activeSubscriptions
          ? _value.activeSubscriptions
          : activeSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      allPurchasedProductIdentifiers: null == allPurchasedProductIdentifiers
          ? _value.allPurchasedProductIdentifiers
          : allPurchasedProductIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nonSubscriptionTransactions: null == nonSubscriptionTransactions
          ? _value.nonSubscriptionTransactions
          : nonSubscriptionTransactions // ignore: cast_nullable_to_non_nullable
              as List<StoreTransaction>,
      firstSeen: null == firstSeen
          ? _value.firstSeen
          : firstSeen // ignore: cast_nullable_to_non_nullable
              as String,
      originalAppUserId: null == originalAppUserId
          ? _value.originalAppUserId
          : originalAppUserId // ignore: cast_nullable_to_non_nullable
              as String,
      allExpirationDates: null == allExpirationDates
          ? _value.allExpirationDates
          : allExpirationDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      requestDate: null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String,
      latestExpirationDate: freezed == latestExpirationDate
          ? _value.latestExpirationDate
          : latestExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalPurchaseDate: freezed == originalPurchaseDate
          ? _value.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalApplicationVersion: freezed == originalApplicationVersion
          ? _value.originalApplicationVersion
          : originalApplicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      managementURL: freezed == managementURL
          ? _value.managementURL
          : managementURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EntitlementInfosCopyWith<$Res> get entitlements {
    return $EntitlementInfosCopyWith<$Res>(_value.entitlements, (value) {
      return _then(_value.copyWith(entitlements: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CustomerInfoCopyWith<$Res>
    implements $CustomerInfoCopyWith<$Res> {
  factory _$$_CustomerInfoCopyWith(
          _$_CustomerInfo value, $Res Function(_$_CustomerInfo) then) =
      __$$_CustomerInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EntitlementInfos entitlements,
      Map<String, String> allPurchaseDates,
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
class __$$_CustomerInfoCopyWithImpl<$Res>
    extends _$CustomerInfoCopyWithImpl<$Res, _$_CustomerInfo>
    implements _$$_CustomerInfoCopyWith<$Res> {
  __$$_CustomerInfoCopyWithImpl(
      _$_CustomerInfo _value, $Res Function(_$_CustomerInfo) _then)
      : super(_value, _then);

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
    return _then(_$_CustomerInfo(
      null == entitlements
          ? _value.entitlements
          : entitlements // ignore: cast_nullable_to_non_nullable
              as EntitlementInfos,
      null == allPurchaseDates
          ? _value._allPurchaseDates
          : allPurchaseDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      null == activeSubscriptions
          ? _value._activeSubscriptions
          : activeSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == allPurchasedProductIdentifiers
          ? _value._allPurchasedProductIdentifiers
          : allPurchasedProductIdentifiers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == nonSubscriptionTransactions
          ? _value._nonSubscriptionTransactions
          : nonSubscriptionTransactions // ignore: cast_nullable_to_non_nullable
              as List<StoreTransaction>,
      null == firstSeen
          ? _value.firstSeen
          : firstSeen // ignore: cast_nullable_to_non_nullable
              as String,
      null == originalAppUserId
          ? _value.originalAppUserId
          : originalAppUserId // ignore: cast_nullable_to_non_nullable
              as String,
      null == allExpirationDates
          ? _value._allExpirationDates
          : allExpirationDates // ignore: cast_nullable_to_non_nullable
              as Map<String, String?>,
      null == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String,
      latestExpirationDate: freezed == latestExpirationDate
          ? _value.latestExpirationDate
          : latestExpirationDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalPurchaseDate: freezed == originalPurchaseDate
          ? _value.originalPurchaseDate
          : originalPurchaseDate // ignore: cast_nullable_to_non_nullable
              as String?,
      originalApplicationVersion: freezed == originalApplicationVersion
          ? _value.originalApplicationVersion
          : originalApplicationVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      managementURL: freezed == managementURL
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
      this.entitlements,
      final Map<String, String> allPurchaseDates,
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

  factory _$_CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$$_CustomerInfoFromJson(json);

  /// Entitlements attached to this customer info
  @override
  final EntitlementInfos entitlements;

  /// Map of skus to purchase dates
  final Map<String, String> _allPurchaseDates;

  /// Map of skus to purchase dates
  @override
  Map<String, String> get allPurchaseDates {
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

  @override
  String toString() {
    return 'CustomerInfo(entitlements: $entitlements, allPurchaseDates: $allPurchaseDates, activeSubscriptions: $activeSubscriptions, allPurchasedProductIdentifiers: $allPurchasedProductIdentifiers, nonSubscriptionTransactions: $nonSubscriptionTransactions, firstSeen: $firstSeen, originalAppUserId: $originalAppUserId, allExpirationDates: $allExpirationDates, requestDate: $requestDate, latestExpirationDate: $latestExpirationDate, originalPurchaseDate: $originalPurchaseDate, originalApplicationVersion: $originalApplicationVersion, managementURL: $managementURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomerInfo &&
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

  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomerInfoCopyWith<_$_CustomerInfo> get copyWith =>
      __$$_CustomerInfoCopyWithImpl<_$_CustomerInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CustomerInfoToJson(
      this,
    );
  }
}

abstract class _CustomerInfo implements CustomerInfo {
  const factory _CustomerInfo(
      final EntitlementInfos entitlements,
      final Map<String, String> allPurchaseDates,
      final List<String> activeSubscriptions,
      final List<String> allPurchasedProductIdentifiers,
      final List<StoreTransaction> nonSubscriptionTransactions,
      final String firstSeen,
      final String originalAppUserId,
      final Map<String, String?> allExpirationDates,
      final String requestDate,
      {final String? latestExpirationDate,
      final String? originalPurchaseDate,
      final String? originalApplicationVersion,
      final String? managementURL}) = _$_CustomerInfo;

  factory _CustomerInfo.fromJson(Map<String, dynamic> json) =
      _$_CustomerInfo.fromJson;

  @override

  /// Entitlements attached to this customer info
  EntitlementInfos get entitlements;
  @override

  /// Map of skus to purchase dates
  Map<String, String> get allPurchaseDates;
  @override

  /// Set of active subscription skus
  List<String> get activeSubscriptions;
  @override

  /// Set of purchased skus, active and inactive
  List<String> get allPurchasedProductIdentifiers;
  @override

  /// Returns all the non-subscription purchases a user has made.
  /// The purchases are ordered by purchase date in ascending order.
  List<StoreTransaction> get nonSubscriptionTransactions;
  @override

  /// The date this user was first seen in RevenueCat.
  String get firstSeen;
  @override

  /// The original App User Id recorded for this user.
  String get originalAppUserId;
  @override

  /// Map of skus to expiration dates
  Map<String, String?> get allExpirationDates;
  @override

  /// Date when this info was requested
  String get requestDate;
  @override

  /// The latest expiration date of all purchased skus
  String? get latestExpirationDate;
  @override

  /// Returns the purchase date for the version of the application when the user bought the app.
  /// Use this for grandfathering users when migrating to subscriptions.
  String? get originalPurchaseDate;
  @override

  /// Returns the version number for the version of the application when the
  /// user bought the app. Use this for grandfathering users when migrating
  /// to subscriptions.
  ///
  /// This corresponds to the value of CFBundleVersion (in iOS) in the
  /// Info.plist file when the purchase was originally made. This is always null
  /// in Android
  String? get originalApplicationVersion;
  @override

  /// URL to manage the active subscription of the user. If this user has an active iOS
  /// subscription, this will point to the App Store, if the user has an active Play Store subscription
  /// it will point there. If there are no active subscriptions it will be null.
  /// If there are multiple for different platforms, it will point to the device store.
  String? get managementURL;
  @override
  @JsonKey(ignore: true)
  _$$_CustomerInfoCopyWith<_$_CustomerInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
