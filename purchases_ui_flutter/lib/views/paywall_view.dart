import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class PaywallView extends StatelessWidget {
  const PaywallView({Key? key}) : super(key: key);

  static const String viewType = 'com.revenuecat.purchasesui/PaywallView';

  @override
  Widget build(BuildContext context) {
    const creationParams = <String, dynamic>{};

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
                      params.onPlatformViewCreated)
                  ..create(),
          )
        : const Text('TODO iOS PaywallView');
  }
}
