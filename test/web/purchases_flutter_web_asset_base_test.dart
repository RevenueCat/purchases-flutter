@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:ui_web' as ui_web;

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:purchases_flutter/web/purchases_flutter_web.dart';
import 'package:web/web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Keep this test in its own file: registerWith only injects the script once
  // per browser isolate because the plugin caches its initialization.
  test('loads the web SDK script using Flutter assetBase', () {
    String? requestedScriptUrl;
    final head = document.head!;
    final append = head['append'] as JSFunction;
    head['append'] = ((HTMLScriptElement script) {
      requestedScriptUrl = script.getAttribute('src');
      script.src = 'data:text/javascript,';
      append.callAsFunction(head, script);
    }).toJS;

    PurchasesFlutterPlugin.assetManager = ui_web.AssetManager(
      assetBase: 'https://cdn.example.com/flutter/',
    );
    PurchasesFlutterPlugin.registerWith(webPluginRegistrar);

    expect(
      requestedScriptUrl,
      'https://cdn.example.com/flutter/assets/packages/purchases_flutter/'
      'assets/web/purchases_js_hybrid_mappings.js',
    );
  });
}
