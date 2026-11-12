@TestOn('browser')
library;

import 'dart:ui_web' as ui_web;

import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/web/asset_url_resolver.dart';

void main() {
  test('resolves the web SDK using the default asset base', () {
    final assetManager = ui_web.AssetManager();

    expect(
      resolvePurchasesHybridMappingsAssetUrl(assetManager),
      'assets/packages/purchases_flutter/assets/web/'
      'purchases_js_hybrid_mappings.js',
    );
  });

  test('resolves the web SDK using Flutter assetBase', () {
    final assetManager = ui_web.AssetManager(
      assetBase: 'https://cdn.example.com/flutter/',
    );

    expect(
      resolvePurchasesHybridMappingsAssetUrl(assetManager),
      'https://cdn.example.com/flutter/assets/packages/purchases_flutter/'
      'assets/web/purchases_js_hybrid_mappings.js',
    );
  });
}
