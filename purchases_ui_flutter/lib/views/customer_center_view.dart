import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'customer_center_view_method_handler.dart';

class CustomerCenterView extends StatelessWidget {
  const CustomerCenterView({
    super.key,
    this.shouldShowCloseButton = true,
    this.onDismiss,
    this.onRestoreStarted,
    this.onRestoreCompleted,
    this.onRestoreFailed,
    this.onShowingManageSubscriptions,
    this.onRefundRequestStarted,
    this.onRefundRequestCompleted,
    this.onFeedbackSurveyCompleted,
    this.onManagementOptionSelected,
    this.onCustomActionSelected,
  });

  final bool shouldShowCloseButton;

  final CustomerCenterDismissCallback? onDismiss;
  final CustomerCenterRestoreStartedCallback? onRestoreStarted;
  final CustomerCenterRestoreCompletedCallback? onRestoreCompleted;
  final CustomerCenterRestoreFailedCallback? onRestoreFailed;
  final CustomerCenterManageSubscriptionsCallback? onShowingManageSubscriptions;
  final CustomerCenterRefundRequestStartedCallback? onRefundRequestStarted;
  final CustomerCenterRefundRequestCompletedCallback? onRefundRequestCompleted;
  final CustomerCenterFeedbackSurveyCompletedCallback? onFeedbackSurveyCompleted;
  final CustomerCenterManagementOptionSelectedCallback? onManagementOptionSelected;
  final CustomerCenterCustomActionSelectedCallback? onCustomActionSelected;

  static const String _viewType = 'com.revenuecat.purchasesui/CustomerCenterView';

  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{
      'shouldShowCloseButton': shouldShowCloseButton,
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
    final handler = CustomerCenterViewMethodHandler(
      onDismiss: onDismiss,
      onRestoreStarted: onRestoreStarted,
      onRestoreCompleted: onRestoreCompleted,
      onRestoreFailed: onRestoreFailed,
      onShowingManageSubscriptions: onShowingManageSubscriptions,
      onRefundRequestStarted: onRefundRequestStarted,
      onRefundRequestCompleted: onRefundRequestCompleted,
      onFeedbackSurveyCompleted: onFeedbackSurveyCompleted,
      onManagementOptionSelected: onManagementOptionSelected,
      onCustomActionSelected: onCustomActionSelected,
    );
    MethodChannel('com.revenuecat.purchasesui/CustomerCenterView/$id')
        .setMethodCallHandler(handler.handleMethodCall);
  }
}
