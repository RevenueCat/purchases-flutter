import 'object_wrappers.dart';

class Entitlement {
  // Map of offerings to their active product for the current platform
  final Map<String, Product> offerings;

  Entitlement.fromJson(Map<dynamic, dynamic> json)
      : offerings = json.map((key, value) =>
            MapEntry(key, value != null ? Product.fromJson(value) : null));

  @override
  String toString() {
    return 'Entitlement{offerings: $offerings}';
  }
}
