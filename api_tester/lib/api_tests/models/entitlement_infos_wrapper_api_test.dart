import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _EntitlementInfosApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    EntitlementInfos entitlementInfos = EntitlementInfos.fromJson(json);
  }

  void _checkToJson(EntitlementInfos entitlementInfos) {
    Map<String, dynamic> json = entitlementInfos.toJson();
  }

  void _checkConstructor(
      Map<String, EntitlementInfo> all, Map<String, EntitlementInfo> active) {
    EntitlementInfos entitlementInfos = EntitlementInfos(all, active);
  }

  void _checkProperties(EntitlementInfos entitlementInfos) {
    Map<String, EntitlementInfo> all = entitlementInfos.all;
    Map<String, EntitlementInfo> active = entitlementInfos.active;
  }
}
