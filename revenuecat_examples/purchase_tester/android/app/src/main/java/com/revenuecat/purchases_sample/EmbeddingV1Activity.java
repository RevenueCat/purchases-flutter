package com.revenuecat.purchases_sample;

import android.os.Bundle;
import com.revenuecat.purchases_flutter.PurchasesFlutterPlugin;
import io.flutter.app.FlutterActivity;
import io.flutter.view.FlutterMain;

public class EmbeddingV1Activity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        FlutterMain.startInitialization(this);
        super.onCreate(savedInstanceState);
        PurchasesFlutterPlugin.registerWith(registrarFor("com.revenuecat.purchases_flutter"));
    }
}