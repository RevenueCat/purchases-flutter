import 'package:freezed_annotation/freezed_annotation.dart';

part 'virtual_currency_info.freezed.dart';
part 'virtual_currency_info.g.dart';

// Contains information about a virtual currency.
@freezed
class VirtualCurrencyInfo with _$VirtualCurrencyInfo {
  const factory VirtualCurrencyInfo(
    /// The user's balance of the virtual currency.
    int balance,
  ) = _VirtualCurrencyInfo;

  factory VirtualCurrencyInfo.fromJson(Map<String, dynamic> json) =>
      _$VirtualCurrencyInfoFromJson(json);
}
