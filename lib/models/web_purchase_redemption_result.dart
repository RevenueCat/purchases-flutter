import 'customer_info_wrapper.dart';
import 'purchases_error.dart';

/// Represents the result of a web purchase redemption
sealed class WebPurchaseRedemptionResult {
  const WebPurchaseRedemptionResult();

  factory WebPurchaseRedemptionResult.fromJson(Map<String, dynamic> json) {
    final resultType = json['result'] as String;
    switch (resultType) {
      case 'SUCCESS':
        return WebPurchaseRedemptionSuccess(
          customerInfo: CustomerInfo.fromJson(
            Map<String, dynamic>.from(json['customerInfo']),
          ),
        );
      case 'ERROR':
        return WebPurchaseRedemptionError(
          error: PurchasesError.fromJson(
            Map<String, dynamic>.from(json['error']),
          ),
        );
      case 'PURCHASE_BELONGS_TO_OTHER_USER':
        return const WebPurchaseRedemptionPurchaseBelongsToOtherUser();
      case 'INVALID_TOKEN':
        return const WebPurchaseRedemptionInvalidToken();
      case 'EXPIRED':
        return WebPurchaseRedemptionExpired(
          obfuscatedEmail: json['obfuscatedEmail'] as String,
        );
      default:
        throw ArgumentError.value(resultType, 'result', 'Invalid value');
    }
  }
}

class WebPurchaseRedemptionSuccess extends WebPurchaseRedemptionResult {
  final CustomerInfo customerInfo;
  const WebPurchaseRedemptionSuccess({required this.customerInfo});
}

class WebPurchaseRedemptionError extends WebPurchaseRedemptionResult {
  final PurchasesError error;
  const WebPurchaseRedemptionError({required this.error});
}

class WebPurchaseRedemptionPurchaseBelongsToOtherUser extends WebPurchaseRedemptionResult {
  const WebPurchaseRedemptionPurchaseBelongsToOtherUser();
}

class WebPurchaseRedemptionInvalidToken extends WebPurchaseRedemptionResult {
  const WebPurchaseRedemptionInvalidToken();
}

class WebPurchaseRedemptionExpired extends WebPurchaseRedemptionResult {
  final String obfuscatedEmail;
  const WebPurchaseRedemptionExpired({required this.obfuscatedEmail});
}
