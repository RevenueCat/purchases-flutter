import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable

class _StoreProductChangeInfoApiTest {
  void _checkConstructor(
    String oldProductIdentifier,
    StoreReplacementMode? replacementMode,
  ) {
    StoreProductChangeInfo purchaseInfo =
        StoreProductChangeInfo(oldProductIdentifier);
    purchaseInfo = StoreProductChangeInfo(
      oldProductIdentifier,
      replacementMode: replacementMode,
    );
  }

  void _checkProperties(StoreProductChangeInfo purchaseInfo) {
    String oldProductIdentifier = purchaseInfo.oldProductIdentifier;
    StoreReplacementMode? replacementMode = purchaseInfo.replacementMode;
  }

  void _checkStoreReplacementMode(StoreReplacementMode replacementMode) {
    switch (replacementMode) {
      case StoreReplacementMode.withTimeProration:
      case StoreReplacementMode.chargeProratedPrice:
      case StoreReplacementMode.withoutProration:
      case StoreReplacementMode.chargeFullPrice:
      case StoreReplacementMode.deferred:
        break;
    }
  }

  void _checkStoreReplacementModeExtension(
    StoreReplacementMode replacementMode,
  ) {
    String value = replacementMode.value;
  }
}
