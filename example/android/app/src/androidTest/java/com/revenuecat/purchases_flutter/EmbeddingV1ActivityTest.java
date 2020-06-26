package com.revenuecat.purchases_flutter;

import androidx.test.rule.ActivityTestRule;

import com.revenuecat.purchases_flutter_example.EmbeddingV1Activity;

import dev.flutter.plugins.e2e.FlutterRunner;
import org.junit.Rule;
import org.junit.runner.RunWith;

@RunWith(FlutterRunner.class)
public class EmbeddingV1ActivityTest {
    @Rule
    public ActivityTestRule<EmbeddingV1Activity> rule =
            new ActivityTestRule<>(EmbeddingV1Activity.class);

}