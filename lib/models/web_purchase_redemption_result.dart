import 'customer_info_wrapper.dart';
import 'purchases_error.dart';

/// Represents the result of a web purchase redemption
sealed class WebPurchaseRedemptionResult {
  const WebPurchaseRedemptionResult();

  factory WebPurchaseRedemptionResult.fromJson(Map<String, dynamic> json) {
    final resultType = json['result'] as String;
    switch (resultType) {
      case 'SUCCESS':
        return WebRedemptionSuccess(
          customerInfo: CustomerInfo.fromJson(
            Map<String, dynamic>.from(json['customerInfo']),
          ),
        );
      case 'ERROR':
        return WebRedemptionError(
          error: PurchasesError.fromJson(
            Map<String, dynamic>.from(json['error']),
          ),
        );
      case 'PURCHASE_BELONGS_TO_OTHER_USER':
        return const WebRedemptionPurchaseBelongsToOtherUser();
      case 'INVALID_TOKEN':
        return const WebRedemptionInvalidToken();
      case 'EXPIRED':
        return WebRedemptionExpired(
          obfuscatedEmail: json['obfuscatedEmail'] as String,
        );
      default:
        throw ArgumentError.value(resultType, 'result', 'Invalid value');
    }
  }
}

class WebRedemptionSuccess extends WebPurchaseRedemptionResult {
  final CustomerInfo customerInfo;
  const WebRedemptionSuccess({required this.customerInfo});
}

class WebRedemptionError extends WebPurchaseRedemptionResult {
  final PurchasesError error;
  const WebRedemptionError({required this.error});
}

class WebRedemptionPurchaseBelongsToOtherUser extends WebPurchaseRedemptionResult {
  const WebRedemptionPurchaseBelongsToOtherUser();
}

class WebRedemptionInvalidToken extends WebPurchaseRedemptionResult {
  const WebRedemptionInvalidToken();
}

class WebRedemptionExpired extends WebPurchaseRedemptionResult {
  final String obfuscatedEmail;
  const WebRedemptionExpired({required this.obfuscatedEmail});
}
