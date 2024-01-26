import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

class PaywallView extends StatelessWidget {
  final Offering? offering;

  const PaywallView({Key? key, this.offering})
      : super(key: key);

  static const String viewType = 'com.revenuecat.purchasesui/PaywallView';

  @override
  Widget build(BuildContext context) {

    final creationParams = <String, dynamic>{
      'offeringIdentifier': offering?.identifier,
    };

    return Platform.isAndroid
        ? PlatformViewLink(
            viewType: viewType,
            surfaceFactory: (context, controller) => AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            ),
            onCreatePlatformView: (params) =>
                PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
                  ..addOnPlatformViewCreatedListener(
                      params.onPlatformViewCreated,
                  )
                  ..create(),
          )
        : const Text('TODO iOS PaywallView');
  }
}
