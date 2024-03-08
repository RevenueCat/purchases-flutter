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

class InternalPaywallFooterView extends StatefulWidget {
  final Offering? offering;
  final Function(Package rcPackage)? onPurchaseStarted;
  final Function(CustomerInfo customerInfo, StoreTransaction storeTransaction)?
  onPurchaseCompleted;
  final Function(PurchasesError)? onPurchaseError;
  final Function(CustomerInfo customerInfo)? onRestoreCompleted;
  final Function(PurchasesError)? onRestoreError;
  final Function(double) onHeightChanged;

  const InternalPaywallFooterView({
    Key? key,
    this.offering,
    this.onPurchaseStarted,
    this.onPurchaseCompleted,
    this.onPurchaseError,
    this.onRestoreCompleted,
    this.onRestoreError,
    required this.onHeightChanged,
  }) : super(key: key);

  static const String _viewType = 'com.revenuecat.purchasesui/PaywallFooterView';

  @override
  State<InternalPaywallFooterView> createState() => _InternalPaywallFooterViewState(
      PaywallViewMethodHandler(
        onPurchaseStarted,
        onPurchaseCompleted,
        onPurchaseError,
        onRestoreCompleted,
        onRestoreError,
      )
  );
}

class _InternalPaywallFooterViewState extends State<InternalPaywallFooterView> {

  final PaywallViewMethodHandler _handler;

  _InternalPaywallFooterViewState(this._handler);

  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{
      'offeringIdentifier': widget.offering?.identifier,
    };

    return Platform.isAndroid
        ? _buildAndroidPlatformViewLink(creationParams)
        : _buildUiKitView(creationParams);
  }

  UiKitView _buildUiKitView(Map<String, dynamic> creationParams) => UiKitView(
    viewType: InternalPaywallFooterView._viewType,
    layoutDirection: TextDirection.ltr,
    creationParams: creationParams,
    creationParamsCodec: const StandardMessageCodec(),
    onPlatformViewCreated: _buildListenerChannel,
  );

  PlatformViewLink _buildAndroidPlatformViewLink(
      Map<String, dynamic> creationParams,
      ) =>
      PlatformViewLink(
        viewType: InternalPaywallFooterView._viewType,
        surfaceFactory: (context, controller) => AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        ),
        onCreatePlatformView: (params) => PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: InternalPaywallFooterView._viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..addOnPlatformViewCreatedListener(_buildListenerChannel)
            ..create(),
      );

  void _buildListenerChannel(int id) {
    MethodChannel('com.revenuecat.purchasesui/PaywallFooterView/$id')
        .setMethodCallHandler((call) async {
      if (call.method == 'onHeightChanged') {
        widget.onHeightChanged(call.arguments as double);
      } else {
        _handler.handleMethodCall(call);
      }
    });
  }
}
