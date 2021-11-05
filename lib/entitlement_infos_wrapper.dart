import 'package:collection/collection.dart';

import 'object_wrappers.dart';

/// This class contains all the entitlements associated to the user.
class EntitlementInfos {
  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  final Map<String, EntitlementInfo> all;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  final Map<String, EntitlementInfo> active;

  /// Constructs an EntitlementInfos from a JSON object
  EntitlementInfos.fromJson(Map<String, dynamic> json)
      : all = (json['all'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            EntitlementInfo.fromJson(value),
          ),
        ),
        active = (json['active'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            EntitlementInfo.fromJson(value),
          ),
        );

  @override
  String toString() => 'EntitlementInfos{all: $all, active: $active}';

  @override
  bool operator ==(other) {
    if (other is! EntitlementInfos) {
      return false;
    }
    final mapEq = const MapEquality().equals;
    return mapEq(all, other.all) && mapEq(active, other.active);
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
