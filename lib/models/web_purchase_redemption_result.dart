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

  Map<String, dynamic> toJson() {
    if (this is WebPurchaseRedemptionSuccess) {
      return {
        'result': 'SUCCESS',
        'customerInfo':
            (this as WebPurchaseRedemptionSuccess).customerInfo.toJson(),
      };
    } else if (this is WebPurchaseRedemptionError) {
      return {
        'result': 'ERROR',
        'error': (this as WebPurchaseRedemptionError).error.toJson(),
      };
    } else if (this is WebPurchaseRedemptionPurchaseBelongsToOtherUser) {
      return {'result': 'PURCHASE_BELONGS_TO_OTHER_USER'};
    } else if (this is WebPurchaseRedemptionInvalidToken) {
      return {'result': 'INVALID_TOKEN'};
    } else if (this is WebPurchaseRedemptionExpired) {
      return {
        'result': 'EXPIRED',
        'obfuscatedEmail':
            (this as WebPurchaseRedemptionExpired).obfuscatedEmail,
      };
    }
    throw ArgumentError('Unknown result type');
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

class WebPurchaseRedemptionPurchaseBelongsToOtherUser
    extends WebPurchaseRedemptionResult {
  const WebPurchaseRedemptionPurchaseBelongsToOtherUser();
}

class WebPurchaseRedemptionInvalidToken extends WebPurchaseRedemptionResult {
  const WebPurchaseRedemptionInvalidToken();
}

class WebPurchaseRedemptionExpired extends WebPurchaseRedemptionResult {
  final String obfuscatedEmail;
  const WebPurchaseRedemptionExpired({required this.obfuscatedEmail});
}
