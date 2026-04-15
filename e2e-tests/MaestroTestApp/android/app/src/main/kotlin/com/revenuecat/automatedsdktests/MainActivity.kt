package com.revenuecat.automatedsdktests

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.revenuecat.maestro/launch_args")
            .setMethodCallHandler { call, result ->
                if (call.method == "getTestFlow") {
                    result.success(intent.getStringExtra("e2e_test_flow"))
                } else {
                    result.notImplemented()
                }
            }
    }
}
