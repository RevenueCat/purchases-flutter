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

/// View that displays the paywall in full screen mode.
/// Not supported in macOS currently.
///
/// [offering] (Optional) The offering object to be displayed in the paywall.
/// Obtained from [Purchases.getOfferings].
///
/// [onPurchaseStarted] (Optional) Callback that gets called when a purchase
/// is started.
///
/// [onPurchaseCompleted] (Optional) Callback that gets called when a purchase
/// is completed.
class PaywallView extends StatelessWidget {
  final Offering? offering;
  final Function(Package rcPackage)? onPurchaseStarted;
  final Function(CustomerInfo customerInfo, StoreTransaction storeTransaction)?
      onPurchaseCompleted;
  final Function(PurchasesError)? onPurchaseError;
  final Function(CustomerInfo customerInfo)? onRestoreCompleted;
  final Function(PurchasesError)? onRestoreError;

  const PaywallView({
    Key? key,
    this.offering,
    this.onPurchaseStarted,
    this.onPurchaseCompleted,
    this.onPurchaseError,
    this.onRestoreCompleted,
    this.onRestoreError,
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
    _listenerChannel =
        MethodChannel('com.revenuecat.purchasesui/PaywallView/$id')
          ..setMethodCallHandler(_handleMethodCall);
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onPurchaseStarted':
        _handleOnPurchaseStarted(call);
        break;
      case 'onPurchaseCompleted':
        _handleOnPurchaseCompleted(call);
        break;
      case 'onPurchaseError':
        _handleOnPurchaseError(call);
        break;
      case 'onRestoreCompleted':
        _handleOnRestoreCompleted(call);
        break;
      case 'onRestoreError':
        _handleOnRestoreError(call);
        break;
      default:
        break;
    }
  }

  void _handleOnPurchaseStarted(MethodCall call) {
    final rcPackage =
        Package.fromJson(Map<String, dynamic>.from(call.arguments));
    onPurchaseStarted?.call(rcPackage);
  }

  void _handleOnPurchaseCompleted(MethodCall call) {
    final arguments = Map<String, dynamic>.from(call.arguments);
    final customerInfo = CustomerInfo.fromJson(
      Map<String, dynamic>.from(arguments['customerInfo']),
    );
    final storeTransaction = StoreTransaction.fromJson(
      Map<String, dynamic>.from(arguments['storeTransaction']),
    );
    onPurchaseCompleted?.call(customerInfo, storeTransaction);
  }

  void _handleOnPurchaseError(MethodCall call) {
    final error =
        PurchasesError.fromJson(Map<String, dynamic>.from(call.arguments));
    onPurchaseError?.call(error);
  }

  void _handleOnRestoreCompleted(MethodCall call) {
    final customerInfo =
        CustomerInfo.fromJson(Map<String, dynamic>.from(call.arguments));
    onRestoreCompleted?.call(customerInfo);
  }

  void _handleOnRestoreError(MethodCall call) {
    final error =
        PurchasesError.fromJson(Map<String, dynamic>.from(call.arguments));
    onRestoreError?.call(error);
  }
}
