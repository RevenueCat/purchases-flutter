import 'object_wrappers.dart';

class EntitlementInfos {

  // Map of all entitlements (active and inactive)
  final Map<String, EntitlementInfo> all;
  // Map of all active entitlements
  final Map<String, EntitlementInfo> active;

  EntitlementInfos.fromJson(Map<dynamic, dynamic> json)
      : all = (json["all"] as Map<dynamic, dynamic>)
          .map((key, value) => MapEntry(key, EntitlementInfo.fromJson(value))),
        active = (json["active"] as Map<dynamic, dynamic>)
            .map((key, value) => MapEntry(key, EntitlementInfo.fromJson(value)));

  @override
  String toString() {
    return 'EntitlementInfos{all: $all, active: $active}';
  }

}
