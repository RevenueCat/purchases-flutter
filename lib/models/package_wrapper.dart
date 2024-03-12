import 'package:freezed_annotation/freezed_annotation.dart';

import '../object_wrappers.dart';

part 'package_wrapper.freezed.dart';
part 'package_wrapper.g.dart';

/// Enumeration of all possible Package types.
enum PackageType {
  /// A package that was defined with a custom identifier.
  @JsonValue('UNKNOWN')
  unknown,

  /// A package that was defined with a custom identifier.
  @JsonValue('CUSTOM')
  custom,

  /// A package configured with the predefined lifetime identifier.
  @JsonValue('LIFETIME')
  lifetime,

  /// A package configured with the predefined annual identifier.
  @JsonValue('ANNUAL')
  annual,

  /// A package configured with the predefined six month identifier.
  @JsonValue('SIX_MONTH')
  sixMonth,

  /// A package configured with the predefined three month identifier.
  @JsonValue('THREE_MONTH')
  threeMonth,

  /// A package configured with the predefined two month identifier.
  @JsonValue('TWO_MONTH')
  twoMonth,

  /// A package configured with the predefined monthly identifier.
  @JsonValue('MONTHLY')
  monthly,

  /// A package configured with the predefined weekly identifier.
  @JsonValue('WEEKLY')
  weekly
}

@freezed

/// Contains information about the product available for the user to purchase.
/// For more info see https://docs.revenuecat.com/docs/entitlements

class Package with _$Package {
  const factory Package(
    /// Unique identifier for this package. Can be one a predefined package type
    /// or a custom one.
    String identifier,

    /// Package type for the product. Will be one of [PackageType].
    // ignore: invalid_annotation_target
    @JsonKey(
      name: 'packageType',
      unknownEnumValue: PackageType.unknown,
    )
    PackageType packageType,

    /// StoreProduct assigned to this package.
    // ignore: invalid_annotation_target
    @JsonKey(name: 'product') StoreProduct storeProduct,

    /// Offering context this package belongs to.
    PresentedOfferingContext presentedOfferingContext,
  ) = _Package;

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
}

extension ExtendedPackage on Package {
  /// Offering this package belongs to.
  @Deprecated('use presentedOfferingContext')
  String get offeringIdentifier => presentedOfferingContext.offeringIdentifier;
}
