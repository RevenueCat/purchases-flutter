import 'package:flutter/services.dart';

enum PurchasesErrorCode {
  unknownError,
  purchaseCancelledError,
  storeProblemError,
  purchaseNotAllowedError,
  purchaseInvalidError,
  productNotAvailableForPurchaseError,
  productAlreadyPurchasedError,
  receiptAlreadyInUseError,
  invalidReceiptError,
  missingReceiptFileError,
  networkError,
  invalidCredentialsError,
  unexpectedBackendResponseError,
  receiptInUseByOtherSubscriberError,
  invalidAppUserIdError,
  operationAlreadyInProgressError,
  unknownBackendError,
  invalidAppleSubscriptionKeyError,
  ineligibleError,
  insufficientPermissionsError,
  paymentPendingError,
  invalidSubscriberAttributesError
}

/// Helper to convert from PlatformExceptions to PurchasesErrorCodes
class PurchasesErrorHelper {

  /// Use this to convert a PlatformException to a PurchasesErrorCode.
  /// It will return `PurchasesErrorCode.unknownError` if the error code is not
  /// in the range of PurchasesErrorCodes.
  ///
  /// ```
  /// try {
  ///    PurchaserInfo purchaserInfo = await Purchases.purchasePackage(package);
  /// } on PlatformException catch (e) {
  ///     var errorCode = PurchasesErrorHelper.getErrorCode(e);
  ///     if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
  ///        print("User cancelled");
  ///     } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
  ///        print("User not allowed to purchase");
  ///     }
  /// }
  /// ```
  static PurchasesErrorCode getErrorCode(PlatformException e) {
    var errorCode = int.parse(e.code);
    if (errorCode >= PurchasesErrorCode.values.length) {
      return PurchasesErrorCode.unknownError;
    }
    return PurchasesErrorCode.values[errorCode];
  }

}
