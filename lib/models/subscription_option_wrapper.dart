import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_option_wrapper.freezed.dart';
part 'subscription_option_wrapper.g.dart';

@freezed
class SubscriptionOption with _$SubscriptionOption {
  const factory SubscriptionOption(
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'storeProductId') String storeProductId,
    @JsonKey(name: 'productId') String productId,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'isBasePlan') bool isBasePlan,
  ) = _SubscriptionOption;

  factory SubscriptionOption.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionOptionFromJson(json);
}
