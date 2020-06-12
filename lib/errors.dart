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

class PurchasesErrorHelper {
  static PurchasesErrorCode getErrorCode(PlatformException e) {
    return PurchasesErrorCode.values[int.parse(e.code)];
  }
}
