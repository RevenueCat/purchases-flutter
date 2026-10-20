@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_flutter/web/purchases_flutter_web.dart';
import 'package:web/web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final calls = <String>[];

  setUpAll(() {
    // The vendored web SDK isn't served in tests. Loads an empty script in its
    // place and exposes a fake that records the calls made to it.
    final head = document.head!;
    final append = head['append'] as JSFunction;
    head['append'] = ((HTMLScriptElement script) {
      script.src = 'data:text/javascript,';
      append.callAsFunction(head, script);
    }).toJS;
    globalContext['PurchasesHybridMappings'] = JSObject()
      ..['PurchasesCommon'] = (JSObject()
        ..['setProxyUrl'] = ((JSString url) {
          calls.add('setProxyUrl(${url.toDart})');
        }).toJS);

    PurchasesFlutterPlugin.registerWith(webPluginRegistrar);
    final plugin = PurchasesFlutterPlugin();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('purchases_flutter'),
      plugin.handleMethodCall,
    );
  });

  setUp(calls.clear);

  test('setProxyURL forwards the URL to the web SDK', () async {
    await Purchases.setProxyURL('https://proxy.example.com');

    expect(calls, ['setProxyUrl(https://proxy.example.com)']);
  });
}
