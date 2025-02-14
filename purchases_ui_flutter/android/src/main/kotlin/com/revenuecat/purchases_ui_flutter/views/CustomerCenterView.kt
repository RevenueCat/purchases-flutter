package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import com.revenuecat.purchases.ui.revenuecatui.views.CustomerCenterView as NativeCustomerCenter

internal class CustomerCenterView(
    context: Context,
    id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String?, Any?>
) : PlatformView, MethodCallHandler {

    private val methodChannel: MethodChannel
    private val nativeCustomerCenterView: NativeCustomerCenter

    override fun getView(): View {
        return nativeCustomerCenterView
    }

    override fun dispose() {}

    init {
        methodChannel = MethodChannel(messenger, "com.revenuecat.purchasesui/CustomerCenterView/$id")
        methodChannel.setMethodCallHandler(this)
        nativeCustomerCenterView = NativeCustomerCenter(
            context = context,
            dismissHandler = { methodChannel.invokeMethod("onDismiss", null) }
        )
    }

    // We currently don't have any communication in this channel from dart to native, so this can be empty.
    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            else -> result.notImplemented()
        }
    }
}
