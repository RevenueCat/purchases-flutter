import 'package:flutter/services.dart';
import 'package:purchases_flutter/errors.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _ErrorsApiTest {
  void _checkPurchasesErrorCode(PurchasesErrorCode code) {
    switch (code) {
      case PurchasesErrorCode.unknownError:
      case PurchasesErrorCode.purchaseCancelledError:
      case PurchasesErrorCode.storeProblemError:
      case PurchasesErrorCode.purchaseNotAllowedError:
      case PurchasesErrorCode.purchaseInvalidError:
      case PurchasesErrorCode.productNotAvailableForPurchaseError:
      case PurchasesErrorCode.productAlreadyPurchasedError:
      case PurchasesErrorCode.receiptAlreadyInUseError:
      case PurchasesErrorCode.invalidReceiptError:
      case PurchasesErrorCode.missingReceiptFileError:
      case PurchasesErrorCode.networkError:
      case PurchasesErrorCode.invalidCredentialsError:
      case PurchasesErrorCode.unexpectedBackendResponseError:
      case PurchasesErrorCode.receiptInUseByOtherSubscriberError:
      case PurchasesErrorCode.invalidAppUserIdError:
      case PurchasesErrorCode.operationAlreadyInProgressError:
      case PurchasesErrorCode.unknownBackendError:
      case PurchasesErrorCode.invalidAppleSubscriptionKeyError:
      case PurchasesErrorCode.ineligibleError:
      case PurchasesErrorCode.insufficientPermissionsError:
      case PurchasesErrorCode.paymentPendingError:
      case PurchasesErrorCode.invalidSubscriberAttributesError:
      case PurchasesErrorCode.logOutWithAnonymousUserError:
      case PurchasesErrorCode.configurationError:
      case PurchasesErrorCode.unsupportedError:
      case PurchasesErrorCode.emptySubscriberAttributesError:
      case PurchasesErrorCode.productDiscountMissingIdentifierError:
      case PurchasesErrorCode.unknownNonNativeError:
      case PurchasesErrorCode.productDiscountMissingSubscriptionGroupIdentifierError:
      case PurchasesErrorCode.customerInfoError:
      case PurchasesErrorCode.systemInfoError:
      case PurchasesErrorCode.beginRefundRequestError:
      case PurchasesErrorCode.productRequestTimeout:
      case PurchasesErrorCode.apiEndpointBlocked:
      case PurchasesErrorCode.invalidPromotionalOfferError:
      case PurchasesErrorCode.offlineConnectionError:
        break;
    }
  }

  void _checkPurchasesErrorHelper(PlatformException e) {
    PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
  }
}
