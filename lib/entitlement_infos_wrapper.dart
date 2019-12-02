import 'object_wrappers.dart';

/// This class contains all the entitlements associated to the user.
class EntitlementInfos {
  /// Map of all EntitlementInfo (`EntitlementInfo`) objects (active and inactive)
  /// keyed by entitlement identifier.
  final Map<String, EntitlementInfo> all;

  /// Map of active EntitlementInfo (`EntitlementInfo`) objects keyed by
  /// entitlement identifier.
  final Map<String, EntitlementInfo> active;

  EntitlementInfos.fromJson(Map<dynamic, dynamic> json)
      : all = (json["all"] as Map<dynamic, dynamic>).map(
            (key, value) => MapEntry(key, EntitlementInfo.fromJson(value))),
        active = (json["active"] as Map<dynamic, dynamic>).map(
            (key, value) => MapEntry(key, EntitlementInfo.fromJson(value)));

  @override
  String toString() {
    return 'EntitlementInfos{all: $all, active: $active}';
  }
}
