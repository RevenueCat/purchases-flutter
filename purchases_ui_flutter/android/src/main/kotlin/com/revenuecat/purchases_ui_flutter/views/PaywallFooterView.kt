package com.revenuecat.purchases_ui_flutter.views

import android.content.Context
import android.util.AttributeSet
import android.util.Log
import android.view.Gravity
import android.view.View
import android.widget.FrameLayout
import androidx.core.view.children
import com.revenuecat.purchases.ui.revenuecatui.ExperimentalPreviewRevenueCatUIPurchasesAPI
import com.revenuecat.purchases.ui.revenuecatui.views.PaywallFooterView as NativePaywallFooterView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

@OptIn(ExperimentalPreviewRevenueCatUIPurchasesAPI::class)
internal class PaywallFooterView(
    context: Context,
    id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String?, Any?>
) : PlatformView {

    private val methodChannel: MethodChannel

    private val nativePaywallFooterView: NativePaywallFooterView

    override fun getView(): View {
        return nativePaywallFooterView
    }

    override fun dispose() {}

    init {
        methodChannel = MethodChannel(messenger, "purchases_ui_flutter/PaywallFooterView/${id}")
        val offeringIdentifier = creationParams["offeringIdentifier"] as String?
        nativePaywallFooterView = object : NativePaywallFooterView(context) {
//
//            var shouldRemeasure = true
//
//            override fun requestLayout() {
//                super.requestLayout()
//                if (shouldRemeasure) {
////                    post(measureAndLayout)
//                }
//            }
//
//            private val measureAndLayout = Runnable {
//                Log.e("TEST", "MEASURE AND LAYOUT")
//                measure(
//                    MeasureSpec.makeMeasureSpec(width, MeasureSpec.EXACTLY),
//                    MeasureSpec.makeMeasureSpec(height, MeasureSpec.EXACTLY)
//                )
//                layout(left, top, right, bottom)
//            }
//
//            override fun onDetachedFromWindow() {
//                super.onDetachedFromWindow()
//                shouldRemeasure = false
//            }

            public override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
                super.onMeasure(widthMeasureSpec, heightMeasureSpec)
                var maxWidth = 0
                var maxHeight = 0
                children.forEach {
                    it.measure(widthMeasureSpec, MeasureSpec.UNSPECIFIED)

                    maxWidth = maxWidth.coerceAtLeast(it.measuredWidth)
                    maxHeight = maxHeight.coerceAtLeast(it.measuredHeight)
                }
                val finalWidth = maxWidth.coerceAtLeast(suggestedMinimumWidth)
                val finalHeight = maxHeight.coerceAtLeast(suggestedMinimumHeight)
                setMeasuredDimension(finalWidth, finalHeight)
                updateHeight(finalHeight.toDouble())
            }
        }
        nativePaywallFooterView.layoutParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.MATCH_PARENT,
            Gravity.BOTTOM
        )
        // TODO add to constructor
        nativePaywallFooterView.setOfferingId(offeringIdentifier)
    }

    private fun updateHeight(newHeight: Double) {
        methodChannel.invokeMethod("onHeightChanged", newHeight)
    }
}
