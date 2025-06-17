
import '../freezed_annotation/freezed_annotation.dart';

part 'web_purchase_redemption.freezed.dart';
part 'web_purchase_redemption.g.dart';

@freezed
abstract class WebPurchaseRedemption with _$WebPurchaseRedemption {
  const factory WebPurchaseRedemption(
      /// The redemption link to be redeemed.
      String redemptionLink,
  ) = _WebPurchaseRedemption;

  factory WebPurchaseRedemption.fromJson(Map<String, dynamic> json) =>
      _$WebPurchaseRedemptionFromJson(json);
}
