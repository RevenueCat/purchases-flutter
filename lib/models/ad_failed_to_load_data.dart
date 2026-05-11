import 'ad_format.dart';
import 'ad_mediator_name.dart';

class AdFailedToLoadData {
  final AdMediatorName mediatorName;
  final AdFormat adFormat;
  final String? placement;
  final String adUnitId;
  final int? mediatorErrorCode;

  const AdFailedToLoadData({
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    this.mediatorErrorCode,
  });

  Map<String, dynamic> toMap() => {
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        if (placement != null) 'placement': placement,
        'adUnitId': adUnitId,
        if (mediatorErrorCode != null) 'mediatorErrorCode': mediatorErrorCode,
      };
}
