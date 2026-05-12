import 'package:meta/meta.dart';

import 'ad_format.dart';
import 'ad_mediator_name.dart';

@experimental
class AdLoadedData {
  final String? networkName;
  final AdMediatorName mediatorName;
  final AdFormat adFormat;
  final String? placement;
  final String adUnitId;
  final String impressionId;

  const AdLoadedData({
    this.networkName,
    required this.mediatorName,
    required this.adFormat,
    this.placement,
    required this.adUnitId,
    required this.impressionId,
  });

  Map<String, dynamic> toMap() => {
        'networkName': networkName,
        'mediatorName': mediatorName.value,
        'adFormat': adFormat.value,
        'placement': placement,
        'adUnitId': adUnitId,
        'impressionId': impressionId,
      };
}
