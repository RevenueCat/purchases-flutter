import 'ad_capture_method.dart';
import 'ad_mediator_name.dart';

class AdRewardPromptShownData {
  final AdMediatorName mediatorName;
  final String? placement;
  final String adUnitId;

  /// Reserved for the official RevenueCat ad-network adapters; leave unset
  /// when tracking manually.
  final AdCaptureMethod? captureMethod;

  const AdRewardPromptShownData({
    required this.mediatorName,
    this.placement,
    required this.adUnitId,
    this.captureMethod,
  });

  Map<String, dynamic> toMap() => {
        'mediatorName': mediatorName.value,
        'placement': placement,
        'adUnitId': adUnitId,
        if (captureMethod != null) 'captureMethod': captureMethod!.value,
      };
}
