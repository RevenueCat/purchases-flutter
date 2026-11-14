import 'dart:ui_web' as ui_web;

const _purchasesHybridMappingsAssetKey =
    'packages/purchases_flutter/assets/web/purchases_js_hybrid_mappings.js';

String resolvePurchasesHybridMappingsAssetUrl(
  ui_web.AssetManager assetManager,
) =>
    assetManager.getAssetUrl(_purchasesHybridMappingsAssetKey);
