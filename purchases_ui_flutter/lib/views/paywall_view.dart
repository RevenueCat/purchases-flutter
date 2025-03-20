import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/purchases_error.dart';
import 'package:purchases_flutter/models/store_transaction.dart';

import 'paywall_view_method_handler.dart';

/// View that displays the paywall in full screen mode.
/// Not supported in macOS currently.
///
/// [offering] (Optional) The offering object to be displayed in the paywall.
/// Obtained from [Purchases.getOfferings].
///
/// [displayCloseButton] (Optional) Whether to display a close button in the
/// paywall. Only available for original template paywalls.
/// Ignored for V2 Paywalls. Defaults to false.
///
/// [onPurchaseStarted] (Optional) Callback that gets called when a purchase
/// is started.
/// 
/// [onPurchaseCancelled] (Optional) Callback that gets called when a purchase
/// is cancelled.
///
/// [onPurchaseCompleted] (Optional) Callback that gets called when a purchase
/// is completed.
///
/// [onPurchaseError] (Optional) Callback that gets called when a purchase
/// fails.
///
/// [onRestoreCompleted] (Optional) Callback that gets called when a restore
/// is completed. Note that this may get called even if no entitlements have
/// been granted in case no relevant purchases were found.
///
/// [onRestoreError] (Optional) Callback that gets called when a restore
/// fails.
///
/// [onDismiss] (Optional) Callback that gets called when the paywall wants to
/// dismiss. Currently, after a purchase is completed or when the close button
/// is tapped.
class PaywallView extends StatelessWidget {
  final Offering? offering;
  final bool? displayCloseButton;
  final Function(Package rcPackage)? onPurchaseStarted;
  final Function(CustomerInfo customerInfo, StoreTransaction storeTransaction)?
      onPurchaseCompleted;
  final Function()? onPurchaseCancelled;
  final Function(PurchasesError)? onPurchaseError;
  final Function(CustomerInfo customerInfo)? onRestoreCompleted;
  final Function(PurchasesError)? onRestoreError;
  final Function()? onDismiss;

  const PaywallView({
    Key? key,
    this.offering,
    this.displayCloseButton,
    this.onPurchaseStarted,
    this.onPurchaseCompleted,
    this.onPurchaseCancelled,
    this.onPurchaseError,
    this.onRestoreCompleted,
    this.onRestoreError,
    this.onDismiss,
  }) : super(key: key);

  static const String _viewType = 'com.revenuecat.purchasesui/PaywallView';

  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{
      'offeringIdentifier': offering?.identifier,
      'displayCloseButton': displayCloseButton,
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
        onPlatformViewCreated: _buildListenerChannel,
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
    final handler = PaywallViewMethodHandler(
      onPurchaseStarted,
      onPurchaseCompleted,
      onPurchaseCancelled,
      onPurchaseError,
      onRestoreCompleted,
      onRestoreError,
      onDismiss,
    );
    MethodChannel('com.revenuecat.purchasesui/PaywallView/$id')
          .setMethodCallHandler(handler.handleMethodCall);
  }
}
