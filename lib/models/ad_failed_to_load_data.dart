import 'package:meta/meta.dart';

import 'ad_format.dart';
import 'ad_mediator_name.dart';

@experimental
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
        'placement': placement,
        'adUnitId': adUnitId,
        'mediatorErrorCode': mediatorErrorCode,
      };
}
