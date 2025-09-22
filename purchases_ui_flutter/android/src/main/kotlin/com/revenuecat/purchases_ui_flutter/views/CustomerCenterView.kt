package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import com.revenuecat.purchases.ui.revenuecatui.views.CustomerCenterView as NativeCustomerCenterView

internal class CustomerCenterView(
    context: Context,
    id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String?, Any?>,
) : PlatformView, MethodCallHandler {

    private val methodChannel: MethodChannel
    private val nativeCustomerCenterView: NativeCustomerCenterView

    init {
        methodChannel = MethodChannel(messenger, "com.revenuecat.purchasesui/CustomerCenterView/$id")
        methodChannel.setMethodCallHandler(this)

        nativeCustomerCenterView = NativeCustomerCenterView(context) {
            methodChannel.invokeMethod("onDismiss", null)
        }
        nativeCustomerCenterView.applyCreationParams(creationParams)
    }

    override fun getView(): View = nativeCustomerCenterView

    override fun dispose() {
        methodChannel.setMethodCallHandler(null)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        result.notImplemented()
    }
}

@Suppress("UNUSED_PARAMETER")
private fun NativeCustomerCenterView.applyCreationParams(creationParams: Map<String?, Any?>) {
    // Currently there are no Android specific configuration options.
    // This extension is reserved for future parameters to keep init tidy.
}
