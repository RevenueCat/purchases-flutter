import 'object_wrappers.dart';
import 'package:collection/collection.dart';

/// This class contains all the entitlements associated to the user.
class EntitlementInfos {
  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  final Map<String, EntitlementInfo> all;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  final Map<String, EntitlementInfo> active;

  /// Constructs an EntitlementInfos from a JSON object
  EntitlementInfos.fromJson(Map<dynamic, dynamic> json)
      : all = (json["all"] as Map<dynamic, dynamic>).map(
            (key, value) => MapEntry(key, EntitlementInfo.fromJson(value))),
        active = (json["active"] as Map<dynamic, dynamic>).map(
            (key, value) => MapEntry(key, EntitlementInfo.fromJson(value)));

  @override
  String toString() {
    return 'EntitlementInfos{all: $all, active: $active}';
  }

  @override
  bool operator ==(other) {
    if (!(other is EntitlementInfos)) {
      return false;
    }
    final mapEq = MapEquality().equals;
    return mapEq(this.all, other.all) && mapEq(this.active, other.active);
  }
}
