import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

import 'internal_paywall_footer_view.dart';

/// View that displays the paywall in footer mode.
/// Not supported in macOS currently.
///
/// [offering] (Optional) The offering object to be displayed in the paywall.
/// Obtained from [Purchases.getOfferings].
///
/// [content] The content to be displayed above the paywall. Make sure you
/// apply a padding to the bottom of your content to avoid overlap. This padding
/// can be obtained from [PaywallFooterView.roundedCornerRadius].
class PaywallFooterView extends StatefulWidget {
  /// The top corner radius of the footer view.
  static const roundedCornerRadius = 20.0;

  final Offering? offering;
  final Widget content;

  const PaywallFooterView({
    Key? key,
    this.offering,
    required this.content,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaywallFooterViewState();
}

class _PaywallFooterViewState extends State<PaywallFooterView> {

  var _height = 264.0; // Need to set it to a value > 0 so it's drawn

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
        bottom: _height - PaywallFooterView.roundedCornerRadius,
        child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: widget.content,
        ),
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
