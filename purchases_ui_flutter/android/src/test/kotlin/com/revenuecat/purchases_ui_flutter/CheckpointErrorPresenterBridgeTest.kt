package com.revenuecat.purchases_ui_flutter

import android.view.ViewGroup
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.BinaryMessenger
import org.junit.Assert.assertNull
import org.junit.Assert.assertSame
import org.junit.Test
import org.mockito.Mockito.mock
import org.mockito.Mockito.`when`

class CheckpointErrorPresenterBridgeTest {
    @Test
    fun selectsTheCallingEngineInsteadOfTheFirstFlutterView() {
        val firstMessenger = mock(BinaryMessenger::class.java)
        val callerMessenger = mock(BinaryMessenger::class.java)
        val first = view(firstMessenger)
        val caller = view(callerMessenger)
        val root = mock(ViewGroup::class.java)
        val nested = mock(ViewGroup::class.java)
        `when`(root.childCount).thenReturn(2)
        `when`(root.getChildAt(0)).thenReturn(first)
        `when`(root.getChildAt(1)).thenReturn(nested)
        `when`(nested.childCount).thenReturn(1)
        `when`(nested.getChildAt(0)).thenReturn(caller)

        assertSame(caller, findCheckpointFlutterView(root, callerMessenger))
        assertSame(first, findCheckpointFlutterView(root, firstMessenger))
        assertNull(findCheckpointFlutterView(root, mock(BinaryMessenger::class.java)))
    }

    @Test
    fun ignoresAFlutterViewThatHasNoAttachedEngine() {
        assertNull(findCheckpointFlutterView(
            mock(FlutterView::class.java), mock(BinaryMessenger::class.java),
        ))
    }

    @Test
    fun acceptsTheDartExecutorMessengerUsedByTheFlutterPluginBinding() {
        val engine = mock(FlutterEngine::class.java)
        val executor = mock(DartExecutor::class.java)
        val view = mock(FlutterView::class.java)
        `when`(engine.dartExecutor).thenReturn(executor)
        `when`(executor.binaryMessenger).thenReturn(mock(BinaryMessenger::class.java))
        `when`(view.attachedFlutterEngine).thenReturn(engine)

        assertSame(view, findCheckpointFlutterView(view, executor))
    }

    private fun view(messenger: BinaryMessenger): FlutterView {
        val engine = mock(FlutterEngine::class.java)
        val executor = mock(DartExecutor::class.java)
        val view = mock(FlutterView::class.java)
        `when`(engine.dartExecutor).thenReturn(executor)
        `when`(executor.binaryMessenger).thenReturn(messenger)
        `when`(view.attachedFlutterEngine).thenReturn(engine)
        return view
    }
}
