// Created by Antonio Pallares. Copyright (c) 2026 RevenueCat, Inc.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

const _apiKey = String.fromEnvironment('REVENUECAT_API_KEY');
const _sdkVersion = String.fromEnvironment('SDK_VERSION');
const _sdkSource = String.fromEnvironment('SDK_SOURCE');
const _launchArgs = MethodChannel('com.revenuecat.sdk-update/launch-args');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setLogLevel(LogLevel.debug);
  await Purchases.configure(PurchasesConfiguration(_apiKey));
  final userId = await Purchases.appUserID;
  final loginUserId = await _launchArgs.invokeMethod<String>('getLoginUserId');
  runApp(
    MaterialApp(
      title: 'SDK update tester',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: HomeScreen(userId: userId, loginUserId: loginUserId),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  final String userId;
  final String? loginUserId;

  const HomeScreen({super.key, required this.userId, this.loginUserId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _userId = widget.userId;
  bool _loggingIn = false;
  String? _error;

  Future<void> _logIn() async {
    setState(() => _loggingIn = true);
    try {
      await Purchases.logIn(widget.loginUserId!);
      final userId = await Purchases.appUserID;
      if (mounted) setState(() => _userId = userId);
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loggingIn = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('SDK update tester')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _label('sdk_version', 'RevenueCat SDK $_sdkVersion $_sdkSource'),
              _label('app_user_id', _userId),
              if (widget.loginUserId != null)
                _button('log_in_button', 'Log in', _loggingIn ? null : _logIn),
              const SizedBox(height: 16),
              _button('purchase_screen_button', 'Purchase', () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const PurchaseScreen(),
                  ),
                );
              }),
              if (_error != null) Text('Error: $_error'),
            ],
          ),
        ),
      );
}

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  Package? _monthly;
  String _entitlements = 'Loading...';
  String? _error;
  bool _purchasing = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final offerings = await Purchases.getOfferings();
      final monthly = offerings.all['no_paywall']?.monthly;
      if (monthly == null) {
        throw StateError(
          'The no_paywall offering must contain a monthly package',
        );
      }
      final info = await Purchases.getCustomerInfo();
      if (mounted) {
        setState(() {
          _monthly = monthly;
          _entitlements = _activeEntitlements(info);
        });
      }
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    }
  }

  Future<void> _purchase() async {
    setState(() => _purchasing = true);
    try {
      final result = await Purchases.purchase(
        PurchaseParams.package(_monthly!),
      );
      if (mounted) {
        setState(
          () => _entitlements = _activeEntitlements(result.customerInfo),
        );
      }
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _purchasing = false);
    }
  }

  String _activeEntitlements(CustomerInfo info) {
    final ids = info.entitlements.active.keys.toList()..sort();
    return ids.isEmpty ? 'None' : ids.join(', ');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Purchase'),
          leading:
              Semantics(identifier: 'back_button', child: const BackButton()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Active entitlements'),
              const SizedBox(height: 16),
              _label('active_entitlements', _entitlements),
              _button(
                'purchase_button',
                'Purchase monthly subscription',
                _monthly == null || _purchasing ? null : _purchase,
              ),
              if (_error != null) Text('Error: $_error'),
            ],
          ),
        ),
      );
}

Widget _label(String id, String text) => Semantics(
      identifier: id,
      label: text,
      excludeSemantics: true,
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(text, style: const TextStyle(fontSize: 14)),
        ),
      ),
    );

Widget _button(String id, String text, VoidCallback? onPressed) => Semantics(
      identifier: id,
      child: SizedBox(
        height: 48,
        child: FilledButton(onPressed: onPressed, child: Text(text)),
      ),
    );
