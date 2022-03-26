import 'package:freezed_annotation/freezed_annotation.dart';

import 'introductory_price.dart';
import 'store_product_discount.dart';

part 'promotional_offer_wrapper.freezed.dart';
part 'promotional_offer_wrapper.g.dart';

@freezed

/// Contains all the product details associated with a PromotionalOffer
class PromotionalOffer with _$PromotionalOffer {
  const factory PromotionalOffer(
    /// The StoreProductDiscount in this offer.
    @JsonKey(name: 'productDiscount') StoreProductDiscount productDiscount,

    /// Maddie TODO should we expose the other members?
  ) = _PromotionalOffer;

  factory PromotionalOffer.fromJson(Map<String, dynamic> json) =>
      _$PromotionalOfferFromJson(json);
}
