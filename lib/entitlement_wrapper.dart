import 'object_wrappers.dart';

class Entitlement {
  final Map<String, Product> offerings;

  Entitlement.fromJson(Map<dynamic, dynamic> json)
      : offerings = json.map((key, value) =>
            MapEntry(key, value != null ? Product.fromJson(value) : null));

  @override
  String toString() {
    return 'Entitlement{offerings: $offerings}';
  }
}
