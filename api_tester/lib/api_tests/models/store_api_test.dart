import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _StoreApiTest {
  void _checkStore(Store store) {
    switch (store) {
      case Store.appStore:
      case Store.macAppStore:
      case Store.playStore:
      case Store.stripe:
      case Store.promotional:
      case Store.unknownStore:
      case Store.amazon:
        break;
    }
  }
}
