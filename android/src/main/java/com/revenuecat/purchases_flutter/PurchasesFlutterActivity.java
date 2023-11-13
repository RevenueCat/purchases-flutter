package com.revenuecat.purchases_flutter;

import android.content.Intent;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.OptIn;
import androidx.fragment.app.FragmentManager;

import com.revenuecat.purchases.ui.revenuecatui.ExperimentalPreviewRevenueCatUIPurchasesAPI;
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallActivityLauncher;
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallResult;
import com.revenuecat.purchases.ui.revenuecatui.activity.PaywallResultHandler;

import io.flutter.embedding.android.FlutterFragment;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugin.common.MethodChannel;

@OptIn(markerClass = ExperimentalPreviewRevenueCatUIPurchasesAPI.class)
public class PurchasesFlutterActivity extends FlutterFragmentActivity implements PaywallResultHandler {
    private PaywallActivityLauncher paywallActivityLauncher;

    private MethodChannel.Result paywallResult;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        paywallActivityLauncher = new PaywallActivityLauncher(this, this);
    }

    void presentPaywall(final MethodChannel.Result result, final @Nullable String requiredEntitlementIdentifier) {
        paywallResult = result;

        if (requiredEntitlementIdentifier != null) {
            paywallActivityLauncher.launchIfNeeded(requiredEntitlementIdentifier);
        } else {
            paywallActivityLauncher.launch();
        }
    }

    @Override
    public void onActivityResult(PaywallResult o) {
        if (paywallResult == null) { return; }

        if (o instanceof PaywallResult.Purchased) {
            paywallResult.success(true);
        } else if (o instanceof PaywallResult.Cancelled) {
            paywallResult.success(false);
        } else if (o instanceof PaywallResult.Error) {
            // TODO: forward error
            paywallResult.success(false);
        }

        paywallResult = null;
    }
}
