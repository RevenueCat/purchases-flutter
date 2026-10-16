import 'ad_capture_method.dart';
import 'ad_format.dart';
import 'ad_mediator_name.dart';

class AdDisplayedData {
  final String? networkName;
  final AdMediatorName mediatorName;
  final AdFormat adFormat;
  final String? placement;
  final String adUnitId;
  final String impressionId;

  /// Reserved for the official RevenueCat ad-network adapters; leave unset
  /// when tracking manually.
  final AdCaptureMethod? captureMethod;

  const AdDisplayedData({
    this.networkName,
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    required this.impressionId,
    this.captureMethod,
  });

  Map<String, dynamic> toMap() => {
        'networkName': networkName,
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        'placement': placement,
        'adUnitId': adUnitId,
        'impressionId': impressionId,
        if (captureMethod != null) 'captureMethod': captureMethod!.value,
      };
}
