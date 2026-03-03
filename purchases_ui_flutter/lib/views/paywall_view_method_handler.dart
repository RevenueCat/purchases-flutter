import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/purchases_error.dart';
import 'package:purchases_flutter/models/store_transaction.dart';

import '../purchase_logic.dart';

class PaywallViewMethodHandler {
  final Function(Package rcPackage)? onPurchaseStarted;
  final Function(CustomerInfo customerInfo, StoreTransaction storeTransaction)?
  onPurchaseCompleted;
  final Function()? onPurchaseCancelled;
  final Function(PurchasesError)? onPurchaseError;
  final Function(CustomerInfo customerInfo)? onRestoreCompleted;
  final Function(PurchasesError)? onRestoreError;
  final Function()? onDismiss;
  final PaywallPurchaseLogic? purchaseLogic;
  final MethodChannel? methodChannel;

  const PaywallViewMethodHandler(
    this.onPurchaseStarted,
    this.onPurchaseCompleted,
    this.onPurchaseCancelled,
    this.onPurchaseError,
    this.onRestoreCompleted,
    this.onRestoreError,
    this.onDismiss, {
    this.purchaseLogic,
    this.methodChannel,
  });

  Future<void> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onPurchaseStarted':
        _handleOnPurchaseStarted(call);
        break;
      case 'onPurchaseCompleted':
        _handleOnPurchaseCompleted(call);
        break;
      case 'onPurchaseCancelled':
        onPurchaseCancelled?.call();
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
      case 'onDismiss':
        onDismiss?.call();
        break;
      case 'onPerformPurchase':
        _handleOnPerformPurchase(call);
        break;
      case 'onPerformRestore':
        _handleOnPerformRestore(call);
        break;
      default:
        break;
    }
  }

  void _handleOnPurchaseStarted(MethodCall call) {
    final rcPackage = Package.fromJson(
      Map<String, dynamic>.from(call.arguments),
    );
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
    final error = PurchasesError.fromJson(
      Map<String, dynamic>.from(call.arguments),
    );
    onPurchaseError?.call(error);
  }

  void _handleOnRestoreCompleted(MethodCall call) {
    final customerInfo = CustomerInfo.fromJson(
      Map<String, dynamic>.from(call.arguments),
    );
    onRestoreCompleted?.call(customerInfo);
  }

  void _handleOnRestoreError(MethodCall call) {
    final error = PurchasesError.fromJson(
      Map<String, dynamic>.from(call.arguments),
    );
    onRestoreError?.call(error);
  }

  Future<void> _handleOnPerformPurchase(MethodCall call) async {
    if (purchaseLogic == null || methodChannel == null) return;
    final arguments = Map<String, dynamic>.from(call.arguments);
    final requestId = arguments['requestId'] as String;
    try {
      final packageMap = Map<String, dynamic>.from(
        arguments['packageBeingPurchased'],
      );
      final package = Package.fromJson(packageMap);
      final result = await purchaseLogic!.performPurchase(package);
      methodChannel!.invokeMethod('resolvePurchaseLogicResult', {
        'requestId': requestId,
        'result': _purchaseLogicResultToString(result),
      });
    } catch (e) {
      methodChannel!.invokeMethod('resolvePurchaseLogicResult', {
        'requestId': requestId,
        'result': 'ERROR',
        'errorMessage': e.toString(),
      });
    }
  }

  Future<void> _handleOnPerformRestore(MethodCall call) async {
    if (purchaseLogic == null || methodChannel == null) return;
    final arguments = Map<String, dynamic>.from(call.arguments);
    final requestId = arguments['requestId'] as String;
    try {
      final result = await purchaseLogic!.performRestore();
      methodChannel!.invokeMethod('resolvePurchaseLogicResult', {
        'requestId': requestId,
        'result': _purchaseLogicResultToString(result),
      });
    } catch (e) {
      methodChannel!.invokeMethod('resolvePurchaseLogicResult', {
        'requestId': requestId,
        'result': 'ERROR',
        'errorMessage': e.toString(),
      });
    }
  }

  String _purchaseLogicResultToString(PurchaseLogicResult result) {
    switch (result) {
      case PurchaseLogicResult.success:
        return 'SUCCESS';
      case PurchaseLogicResult.cancellation:
        return 'CANCELLATION';
      case PurchaseLogicResult.error:
        return 'ERROR';
    }
  }
}
