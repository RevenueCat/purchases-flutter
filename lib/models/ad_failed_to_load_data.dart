import 'ad_capture_method.dart';
import 'ad_format.dart';
import 'ad_mediator_name.dart';

class AdFailedToLoadData {
  final AdMediatorName mediatorName;
  final AdFormat adFormat;
  final String? placement;
  final String adUnitId;
  final int? mediatorErrorCode;

  /// Reserved for the official RevenueCat ad-network adapters; leave unset
  /// when tracking manually.
  final AdCaptureMethod? captureMethod;

  const AdFailedToLoadData({
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    this.mediatorErrorCode,
    this.captureMethod,
  });

  Map<String, dynamic> toMap() => {
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        'placement': placement,
        'adUnitId': adUnitId,
        'mediatorErrorCode': mediatorErrorCode,
        if (captureMethod != null) 'captureMethod': captureMethod!.value,
      };
}
