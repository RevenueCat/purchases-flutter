// Created by Antonio Pallares. Copyright (c) 2026 RevenueCat, Inc.

import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    let channel = FlutterMethodChannel(
      name: "com.revenuecat.sdk-update/launch-args",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    channel.setMethodCallHandler { call, result in
      guard call.method == "getLoginUserId" else {
        result(FlutterMethodNotImplemented)
        return
      }
      let arguments = ProcessInfo.processInfo.arguments
      if let index = arguments.firstIndex(of: "-app_user_id_to_log_in"),
         index + 1 < arguments.count {
        result(arguments[index + 1])
      } else {
        result(nil)
      }
    }
  }
}
