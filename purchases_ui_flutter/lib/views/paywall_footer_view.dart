import 'dart:io';

import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

import 'internal_paywall_footer_view.dart';

/// View that displays the paywall in footer mode.
/// Not supported in macOS currently.
///
/// [offering] (Optional) The offering object to be displayed in the paywall.
/// Obtained from [Purchases.getOfferings].
///
/// [contentCreator] A function that creates the content to be displayed above
/// the paywall. Make sure you apply the given padding to the bottom of your
/// content to avoid overlap.
class PaywallFooterView extends StatefulWidget {

  final Offering? offering;
  final Widget Function(double bottomPadding) contentCreator;

  const PaywallFooterView({
    Key? key,
    this.offering,
    required this.contentCreator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaywallFooterViewState();
}

class _PaywallFooterViewState extends State<PaywallFooterView> {
  static const _roundedCornerRadius = 20.0;

  // Need to set it to a value > 0 so it's drawn. Setting it to a value that
  // approximately reflects what the footer view height will be, so redrawing
  // is not so noticeable. Need to improve this.
  var _height = 10.0;

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
        // iOS is passing the size without including the top margin with the
        // rounded corners, so we need to adjust the bottom position.
        bottom: Platform.isAndroid
            ? _height - _roundedCornerRadius
            : _height,
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
            onHeightChanged: _updateHeight,
          ),
        ),
      ),
    ],
  );

  void _updateHeight(double newHeight) {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final finalNewHeight = newHeight / pixelRatio;

    if (_height != finalNewHeight) {
      setState(() {
        _height = finalNewHeight;
      });
    }
  }
}
