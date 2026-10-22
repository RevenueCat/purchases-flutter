import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../android_platform_view_mode.dart';
import '../src/android_platform_view.dart';
import 'customer_center_view_method_handler.dart';

/// A widget that displays the customer center inline within your app.
///
/// This allows users to manage their subscriptions, request refunds, and access
/// customer support without leaving your app's context.
///
/// [androidPlatformViewMode] controls how this view is hosted on Android.
/// By default, Flutter attempts to use Texture Layer Hybrid Composition.
/// Hybrid Composition is more expensive, but can work around platform-view
/// rendering issues on some Android 10 devices. Ignored on iOS and macOS.
class CustomerCenterView extends StatelessWidget {
  const CustomerCenterView({
    super.key,
    this.shouldShowCloseButton = true,
    this.androidPlatformViewMode =
        AndroidPlatformViewMode.textureLayerHybridComposition,
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
    this.onPromotionalOfferSucceeded,
  });

  /// Whether to show a close button in the customer center.
  ///
  /// **Platform Support:**
  /// - **iOS**: Fully supported. When `false`, no close button is shown.
  /// - **Android**: Not supported. Close button is always shown regardless of this setting.
  ///
  /// Defaults to `true`.
  final bool shouldShowCloseButton;

  /// The mode used to host this view on Android.
  ///
  /// Ignored on iOS and macOS.
  final AndroidPlatformViewMode androidPlatformViewMode;

  final CustomerCenterOnDismiss? onDismiss;
  final CustomerCenterRestoreStarted? onRestoreStarted;
  final CustomerCenterRestoreCompleted? onRestoreCompleted;
  final CustomerCenterRestoreFailed? onRestoreFailed;
  final CustomerCenterManageSubscriptions? onShowingManageSubscriptions;
  final CustomerCenterRefundRequestStarted? onRefundRequestStarted;
  final CustomerCenterRefundRequestCompleted? onRefundRequestCompleted;
  final CustomerCenterFeedbackSurveyCompleted? onFeedbackSurveyCompleted;
  final CustomerCenterManagementOptionSelected? onManagementOptionSelected;
  final CustomerCenterCustomActionSelected? onCustomActionSelected;

  /// Called when a promotional offer purchase completes successfully,
  /// providing the resulting customer info, transaction, and the promotional offer identifier.
  final CustomerCenterPromotionalOfferSucceeded? onPromotionalOfferSucceeded;

  static const String _viewType =
      'com.revenuecat.purchasesui/CustomerCenterView';

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
      buildAndroidPlatformViewLink(
        viewType: _viewType,
        creationParams: creationParams,
        mode: androidPlatformViewMode,
        onPlatformViewCreated: _buildListenerChannel,
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
      onPromotionalOfferSucceeded: onPromotionalOfferSucceeded,
    );
    MethodChannel(
      'com.revenuecat.purchasesui/CustomerCenterView/$id',
    ).setMethodCallHandler(handler.handleMethodCall);
  }
}
