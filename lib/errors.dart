import 'package:flutter/services.dart';

/// Different error codes returned by the Purchases functions.
enum PurchasesErrorCode {
  /// Unknown error
  unknownError,

  /// Purchase was cancelled.
  purchaseCancelledError,

  /// There was a problem with the store.
  storeProblemError,

  /// The device or user is not allowed to make the purchase.
  purchaseNotAllowedError,

  /// One or more of the arguments provided are invalid.
  purchaseInvalidError,

  /// The product is not available for purchase.
  productNotAvailableForPurchaseError,

  /// This product is already active for the user.
  productAlreadyPurchasedError,

  /// There is already another active subscriber using the same receipt.
  receiptAlreadyInUseError,

  /// The receipt is not valid.
  invalidReceiptError,

  /// The receipt is missing.
  missingReceiptFileError,

  /// Error performing request.
  networkError,

  /// There was a credentials issue. Check the message for more info.
  invalidCredentialsError,

  /// Received malformed response from the backend.
  unexpectedBackendResponseError,

  /// There is already another active subscriber using the same receipt.
  receiptInUseByOtherSubscriberError,

  /// The app user id is not valid.
  invalidAppUserIdError,

  /// The operation is already in progress.
  operationAlreadyInProgressError,

  /// There was an unknown backend error.
  unknownBackendError,

  /// Apple Subscription Key is invalid or not present. In order to provide
  /// subscription offers, you must first generate a subscription key. Please
  /// see https://docs.revenuecat.com/docs/ios-subscription-offers
  /// for more info.
  invalidAppleSubscriptionKeyError,

  /// The User is ineligible for that action.
  ineligibleError,

  /// App does not have sufficient permissions to make purchases.
  insufficientPermissionsError,

  /// The payment is pending.
  paymentPendingError,

  /// One or more of the attributes sent could not be saved.
  invalidSubscriberAttributesError,

  /// Called logOut but the current user is anonymous.
  logOutWithAnonymousUserError,

  /// There is an issue with your configuration. Check the underlying error for more details.
  configurationError,

  /// There was a problem with the operation. Looks like we doesn't support that yet.
  /// Check the underlying error for more details.
  unsupportedError,
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
  ///     switch(errorCode) {
  ///     case PurchasesErrorCode.purchaseCancelledError:
  ///       print("User cancelled");
  ///       break;
  ///     case PurchasesErrorCode.purchaseNotAllowedError:
  ///       print("User not allowed to purchase");
  ///       break;
  ///     default:
  ///       // Do other stuff
  ///       break;
  ///   }
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
