package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.util.AttributeSet
import android.view.View
import com.revenuecat.purchases.ui.revenuecatui.ExperimentalPreviewRevenueCatUIPurchasesAPI
import io.flutter.plugin.platform.PlatformView
import com.revenuecat.purchases.ui.revenuecatui.views.PaywallView as NativePaywallView

@OptIn(ExperimentalPreviewRevenueCatUIPurchasesAPI::class)
internal class PaywallView(
    context: Context,
    id: Int,
    creationParams: Map<String?, Any?>
) : PlatformView {

    private val nativePaywallView: NativePaywallView

    override fun getView(): View {
        return nativePaywallView
    }

    override fun dispose() {}

    init {
        val offeringIdentifier = creationParams["offeringIdentifier"] as String?
        nativePaywallView = NativePaywallView(context,)
        // TODO add to constructor
        nativePaywallView.setOfferingId(offeringIdentifier)
    }
}
