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

import '../custom_variable_value.dart';
import '../purchase_logic.dart';
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
///
/// [onWebCheckoutOpened] (Optional) Callback that gets called when the user
/// taps a web checkout CTA and leaves the app to complete payment externally.
///
/// [onUrlOpened] (Optional) Callback that gets called when the paywall opens a
/// URL from a button URL destination or a text link. Not called for web
/// checkout URLs.
///
/// [onInteraction] (Optional) Callback that gets called when the user
/// interacts with a paywall control (tab, package, purchase button, ...).
/// Receives the `paywall_component_interacted` event as a map of snake_case
/// keys; keys that do not apply are absent. See
/// https://rev.cat/paywall-interaction-events for the keys each component
/// type sends.
///
/// [customVariables] (Optional) A map of custom variable names to their values.
/// These values can be used for text substitution in paywalls using the
/// `{{ custom.variable_name }}` syntax.
///
/// [purchaseLogic] (Optional) Custom purchase logic to handle purchases and
/// restores when `purchasesAreCompletedBy` is set to `myApp`. When provided,
/// the paywall will delegate purchase and restore operations to this
/// implementation instead of using RevenueCat's default flow.
class PaywallView extends StatefulWidget {
  final Offering? offering;
  final bool? displayCloseButton;
  final Map<String, CustomVariableValue>? customVariables;
  final PaywallPurchaseLogic? purchaseLogic;
  final Function(Package rcPackage)? onPurchaseStarted;
  final Function(CustomerInfo customerInfo, StoreTransaction storeTransaction)?
  onPurchaseCompleted;
  final Function()? onPurchaseCancelled;
  final Function(PurchasesError)? onPurchaseError;
  final Function(CustomerInfo customerInfo)? onRestoreCompleted;
  final Function(PurchasesError)? onRestoreError;
  final Function()? onDismiss;
  final Function()? onWebCheckoutOpened;
  final Function(String url)? onUrlOpened;
  final Function(Map<String, dynamic> event)? onInteraction;

  const PaywallView({
    Key? key,
    this.offering,
    this.displayCloseButton,
    this.customVariables,
    this.purchaseLogic,
    this.onPurchaseStarted,
    this.onPurchaseCompleted,
    this.onPurchaseCancelled,
    this.onPurchaseError,
    this.onRestoreCompleted,
    this.onRestoreError,
    this.onDismiss,
    this.onWebCheckoutOpened,
    this.onUrlOpened,
    this.onInteraction,
  }) : super(key: key);

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  static const String _viewType = 'com.revenuecat.purchasesui/PaywallView';

  // Native paywall views hitch the transition, so wait until it finishes.
  bool _showPlatformView = false;
  Animation<double>? _routeAnimation;
  MethodChannel? _methodChannel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final animation = ModalRoute.of(context)?.animation;
    if (identical(animation, _routeAnimation)) {
      return;
    }
    _routeAnimation?.removeStatusListener(_handleRouteStatus);
    _routeAnimation = animation;
    if (_showPlatformView) {
      return;
    }
    if (animation == null || animation.status == AnimationStatus.completed) {
      _showPlatformView = true;
    } else {
      animation.addStatusListener(_handleRouteStatus);
    }
  }

  void _handleRouteStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) {
      return;
    }
    _routeAnimation?.removeStatusListener(_handleRouteStatus);
    setState(() => _showPlatformView = true);
  }

  @override
  void dispose() {
    _routeAnimation?.removeStatusListener(_handleRouteStatus);
    _methodChannel?.setMethodCallHandler(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_showPlatformView) {
      return const SizedBox.expand();
    }
    final presentedOfferingContext =
        widget.offering?.availablePackages
            .elementAtOrNull(0)
            ?.presentedOfferingContext;
    final creationParams = <String, dynamic>{
      'offeringIdentifier': widget.offering?.identifier,
      'presentedOfferingContext': presentedOfferingContext?.toJson(),
      'displayCloseButton': widget.displayCloseButton,
      'customVariables': convertCustomVariablesToNative(widget.customVariables),
      'hasPurchaseLogic': widget.purchaseLogic != null,
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
  ) => PlatformViewLink(
    viewType: _viewType,
    surfaceFactory:
        (context, controller) => AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        ),
    onCreatePlatformView:
        (params) =>
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
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..addOnPlatformViewCreatedListener(_buildListenerChannel)
              ..create(),
  );

  void _buildListenerChannel(int id) {
    final methodChannel = MethodChannel(
      'com.revenuecat.purchasesui/PaywallView/$id',
    );
    _methodChannel = methodChannel;
    final handler = PaywallViewMethodHandler(
      widget.onPurchaseStarted,
      widget.onPurchaseCompleted,
      widget.onPurchaseCancelled,
      widget.onPurchaseError,
      widget.onRestoreCompleted,
      widget.onRestoreError,
      widget.onDismiss,
      onWebCheckoutOpened: widget.onWebCheckoutOpened,
      onUrlOpened: widget.onUrlOpened,
      onInteraction: widget.onInteraction,
      purchaseLogic: widget.purchaseLogic,
      methodChannel: methodChannel,
    );
    methodChannel.setMethodCallHandler(handler.handleMethodCall);
  }
}
