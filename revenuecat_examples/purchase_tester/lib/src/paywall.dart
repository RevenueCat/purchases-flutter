import 'dart:async';

import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';

// ignore: public_member_api_docs
class PaywallScreen extends StatefulWidget {
  final Offering? offering;

  const PaywallScreen({Key? key, this.offering}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // Wrap your body content with SafeArea
        child: Center(
          child: PaywallView(offering: widget.offering,),
        ),
      ),
    );
  }
}
