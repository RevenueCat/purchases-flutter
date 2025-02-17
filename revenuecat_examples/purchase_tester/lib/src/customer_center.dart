import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:flutter/material.dart';

class CustomerCenterScreen extends StatefulWidget {
  const CustomerCenterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomerCenterScreenState();
}

class _CustomerCenterScreenState extends State<CustomerCenterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomerCenterView(
        onDismiss: () {
          print('Customer Center asked to dismiss');
          Navigator.pop(context);
        },
      ),
    );
  }
}
