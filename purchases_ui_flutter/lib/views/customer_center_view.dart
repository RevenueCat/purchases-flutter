import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CustomerCenterView extends StatelessWidget {
  final Function()? onDismiss;

  const CustomerCenterView({
    Key? key,
    this.onDismiss,
  }) : super(key: key);

  static const String _viewType = 'com.revenuecat.purchasesui/CustomerCenterView';

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? _buildAndroidPlatformViewLink()
        : _buildUiKitView();
  }

  UiKitView _buildUiKitView() => UiKitView(
    viewType: _viewType,
    layoutDirection: TextDirection.ltr,
    creationParamsCodec: const StandardMessageCodec(),
    onPlatformViewCreated: _buildListenerChannel,
  );

  PlatformViewLink _buildAndroidPlatformViewLink() => PlatformViewLink(
    viewType: _viewType,
    surfaceFactory: (context, controller) => AndroidViewSurface(
      controller: controller as AndroidViewController,
      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
    ),
    onCreatePlatformView: (params) =>
    PlatformViewsService.initSurfaceAndroidView(
      id: params.id,
      viewType: _viewType,
      layoutDirection: TextDirection.ltr,
      creationParamsCodec: const StandardMessageCodec(),
      onFocus: () {
        params.onFocusChanged(true);
      },
    )
      ..addOnPlatformViewCreatedListener(
        params.onPlatformViewCreated,
      )
      ..addOnPlatformViewCreatedListener(
        _buildListenerChannel,
      )
      ..create(),
  );

  void _buildListenerChannel(int id) {
    MethodChannel('com.revenuecat.purchasesui/CustomerCenterView/$id')
        .setMethodCallHandler((call) async {
      if (call.method == 'onDismiss') {
        onDismiss?.call();
      }
    });
  }
}