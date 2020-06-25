package com.revenuecat.purchases_flutter_example;

import android.os.Bundle;
import com.revenuecat.purchases_flutter.PurchasesFlutterPlugin;
import io.flutter.app.FlutterActivity;

public class EmbeddingV1Activity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        PurchasesFlutterPlugin.registerWith(registrarFor("com.revenuecat.purchases_flutter.PurchasesFlutterPlugin"));
    }
}