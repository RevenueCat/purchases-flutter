import 'ad_mediator_name.dart';

class AdRewardPromptShownData {
  final AdMediatorName mediatorName;
  final String? placement;
  final String adUnitId;

  const AdRewardPromptShownData({
    required this.mediatorName,
    this.placement,
    required this.adUnitId,
  });

  Map<String, dynamic> toMap() => {
        'mediatorName': mediatorName.value,
        'placement': placement,
        'adUnitId': adUnitId,
      };
}
