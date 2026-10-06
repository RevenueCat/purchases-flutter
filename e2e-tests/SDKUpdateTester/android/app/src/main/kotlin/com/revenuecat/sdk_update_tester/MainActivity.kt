// Created by Antonio Pallares. Copyright (c) 2026 RevenueCat, Inc.

package com.revenuecat.sdk_update_tester

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.revenuecat.sdk-update/launch-args")
            .setMethodCallHandler { call, result ->
                if (call.method == "getLoginUserId") {
                    result.success(intent.getStringExtra("app_user_id_to_log_in"))
                } else {
                    result.notImplemented()
                }
            }
    }
}
