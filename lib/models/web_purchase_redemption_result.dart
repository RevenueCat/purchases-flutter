import '../freezed_annotation/freezed_annotation.dart';
import 'customer_info_wrapper.dart';
import 'purchases_error.dart';

part 'web_purchase_redemption_result.freezed.dart';

@freezed
sealed class WebPurchaseRedemptionResult with _$WebPurchaseRedemptionResult {
  const WebPurchaseRedemptionResult._();

  const factory WebPurchaseRedemptionResult.success({
    required CustomerInfo customerInfo,
  }) = Success;
  const factory WebPurchaseRedemptionResult.error({
    required PurchasesError error,
  }) = Error;
  const factory WebPurchaseRedemptionResult.purchaseBelongsToOtherUser() =
      PurchaseBelongsToOtherUser;
  const factory WebPurchaseRedemptionResult.invalidToken() = InvalidToken;
  const factory WebPurchaseRedemptionResult.expired({
    required String obfuscatedEmail,
  }) = Expired;

  factory WebPurchaseRedemptionResult.fromJson(Map<String, dynamic> json) {
    final resultType = json['result'] as String;
    switch (resultType) {
      case 'SUCCESS':
        return WebPurchaseRedemptionResult.success(
          customerInfo: CustomerInfo.fromJson(
            Map<String, dynamic>.from(json['customerInfo'] as Map),
          ),
        );
      case 'ERROR':
        return WebPurchaseRedemptionResult.error(
          error: PurchasesError.fromJson(
            Map<String, dynamic>.from(json['error'] as Map),
          ),
        );
      case 'PURCHASE_BELONGS_TO_OTHER_USER':
        return const WebPurchaseRedemptionResult.purchaseBelongsToOtherUser();
      case 'INVALID_TOKEN':
        return const WebPurchaseRedemptionResult.invalidToken();
      case 'EXPIRED':
        return WebPurchaseRedemptionResult.expired(
          obfuscatedEmail: json['obfuscatedEmail'] as String,
        );
      default:
        throw ArgumentError.value(resultType, 'result', 'Invalid value');
    }
  }
}
