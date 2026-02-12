import 'dart:io';

import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:purchases_flutter/models/purchases_error.dart';
import 'package:purchases_flutter/models/store_transaction.dart';

import 'internal_paywall_footer_view.dart';

/// View that displays the paywall in footer mode.
/// Not supported in macOS currently. Only available for original template paywalls. Ignored for V2 Paywalls.
///
/// [offering] (Optional) The offering object to be displayed in the paywall.
/// Obtained from [Purchases.getOfferings].
///
/// [onPurchaseStarted] (Optional) Callback that gets called when a purchase
/// is started.
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
/// dismiss. Currently, after a purchase is completed.
///
/// [contentCreator] A function that creates the content to be displayed above
/// the paywall. Make sure you apply the given padding to the bottom of your
/// content to avoid overlap.
@Deprecated('use OriginalTemplatePaywallFooterView instead')
class PaywallFooterView extends OriginalTemplatePaywallFooterView {
  @Deprecated('use OriginalTemplatePaywallFooterView instead')
  const PaywallFooterView({
    Key? key,
    Offering? offering,
    Function(Package rcPackage)? onPurchaseStarted,
    Function(CustomerInfo customerInfo, StoreTransaction storeTransaction)? onPurchaseCompleted,
    Function()? onPurchaseCancelled,
    Function(PurchasesError)? onPurchaseError,
    Function(CustomerInfo customerInfo)? onRestoreCompleted,
    Function(PurchasesError)? onRestoreError,
    Function()? onDismiss,
    required Widget Function(double bottomPadding) contentCreator,
  }) : super(
      key: key,
      offering: offering,
      onPurchaseStarted: onPurchaseStarted,
      onPurchaseCompleted: onPurchaseCompleted,
      onPurchaseCancelled: onPurchaseCancelled,
      onPurchaseError: onPurchaseError,
      onRestoreCompleted: onRestoreCompleted,
      onRestoreError: onRestoreError,
      onDismiss: onDismiss,
      contentCreator: contentCreator,
  );
}

/// View that displays the paywall in footer mode.
/// Not supported in macOS currently. Only available for original template paywalls. Ignored for V2 Paywalls.
///
/// [offering] (Optional) The offering object to be displayed in the paywall.
/// Obtained from [Purchases.getOfferings].
///
/// [onPurchaseStarted] (Optional) Callback that gets called when a purchase
/// is started.
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
/// dismiss. Currently, after a purchase is completed.
///
/// [contentCreator] A function that creates the content to be displayed above
/// the paywall. Make sure you apply the given padding to the bottom of your
/// content to avoid overlap.
class OriginalTemplatePaywallFooterView extends StatefulWidget {

  final Offering? offering;
  final Function(Package rcPackage)? onPurchaseStarted;
  final Function(CustomerInfo customerInfo, StoreTransaction storeTransaction)?
  onPurchaseCompleted;
  final Function()? onPurchaseCancelled;
  final Function(PurchasesError)? onPurchaseError;
  final Function(CustomerInfo customerInfo)? onRestoreCompleted;
  final Function(PurchasesError)? onRestoreError;
  final Function()? onDismiss;
  final Widget Function(double bottomPadding) contentCreator;

  const OriginalTemplatePaywallFooterView({
    Key? key,
    this.offering,
    this.onPurchaseStarted,
    this.onPurchaseCompleted,
    this.onPurchaseCancelled,
    this.onPurchaseError,
    this.onRestoreCompleted,
    this.onRestoreError,
    this.onDismiss,
    required this.contentCreator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaywallFooterViewState();
}

class _PaywallFooterViewState extends State<OriginalTemplatePaywallFooterView> {
  static const _roundedCornerRadius = 20.0;

  // Need to set it to a value > 0 so it's drawn. Setting it to a value that
  // approximately reflects what the footer view height will be, so redrawing
  // is not so noticeable. Need to improve this.
  var _height = 264.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: _height - _roundedCornerRadius,
        child: widget.contentCreator(_roundedCornerRadius),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          width: double.infinity,
          height: _height,
          child: InternalPaywallFooterView(
            offering: widget.offering,
            onPurchaseStarted: widget.onPurchaseStarted,
            onPurchaseCompleted: widget.onPurchaseCompleted,
            onPurchaseCancelled: widget.onPurchaseCancelled,
            onPurchaseError: widget.onPurchaseError,
            onRestoreCompleted: widget.onRestoreCompleted,
            onRestoreError: widget.onRestoreError,
            onDismiss: widget.onDismiss,
            onHeightChanged: _updateHeight,
          ),
        ),
      ),
    ],
  );

  void _updateHeight(double newHeight) {
    // In android we get pixels but in iOS we get pixel independent units.
    final pixelRatio = Platform.isAndroid
        ? MediaQuery.of(context).devicePixelRatio
        : 1.0;
    final finalNewHeight = newHeight / pixelRatio;

    if (_height != finalNewHeight) {
      setState(() {
        _height = finalNewHeight;
      });
    }
  }
}
