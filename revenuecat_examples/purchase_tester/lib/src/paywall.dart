import 'dart:async';

import 'package:purchases_ui_flutter/views/paywall_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';
import 'cats.dart';
import 'upsell.dart';

// ignore: public_member_api_docs
class PaywallScreen extends StatefulWidget {
  const PaywallScreen({Key? key}) : super(key: key);

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
    return const Scaffold(
      body: Center(
        child: PaywallView(),
      ),
    );
  }
}
