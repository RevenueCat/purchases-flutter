import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';

/// View that displays the paywall in full screen mode.
///
/// [offering] (Optional) The offering object to be displayed in the paywall.
/// Obtained from [Purchases.getOfferings].
///
/// [onPurchaseStarted] (Optional) Callback that gets called when a purchase
/// is started.
class PaywallView extends StatelessWidget {
  final Offering? offering;
  final Function(Package rcPackage)? onPurchaseStarted;
  MethodChannel? _listenerChannel;

  PaywallView({
    Key? key,
    this.offering,
    this.onPurchaseStarted,
  }) : super(key: key);

  static const String _viewType = 'com.revenuecat.purchasesui/PaywallView';

  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{
      'offeringIdentifier': offering?.identifier,
    };

    return Platform.isAndroid
        ? _buildAndroidPlatformViewLink(creationParams)
        : _buildUiKitView(creationParams);
  }

  UiKitView _buildUiKitView(Map<String, dynamic> creationParams) => UiKitView(
      viewType: _viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
  );

  PlatformViewLink _buildAndroidPlatformViewLink(
      Map<String, dynamic> creationParams,
  ) =>
      PlatformViewLink(
        viewType: _viewType,
        surfaceFactory: (context, controller) => AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        ),
        onCreatePlatformView: (params) =>
            PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: _viewType,
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
              ..addOnPlatformViewCreatedListener(
                _buildListenerChannel,
              )
              ..create(),
      );

  void _buildListenerChannel(int id) {
    _listenerChannel = MethodChannel(
        'com.revenuecat.purchasesui/PaywallView/$id'
    )
      ..setMethodCallHandler((call) async {
        if (call.method == 'onPurchaseStarted') {
          final rcPackage = Package.fromJson(
              Map<String, dynamic>.from(call.arguments)
          );
          onPurchaseStarted?.call(rcPackage);
        }
        return null;
      });
  }
}
