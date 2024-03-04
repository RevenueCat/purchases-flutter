import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';

class InternalPaywallFooterView extends StatefulWidget {
  final Offering? offering;
  final Function(double) onHeightChanged;

  const InternalPaywallFooterView({
    Key? key,
    this.offering,
    required this.onHeightChanged,
  }) : super(key: key);

  static const String _viewType = 'com.revenuecat.purchasesui/PaywallFooterView';

  @override
  State<InternalPaywallFooterView> createState() => _InternalPaywallFooterViewState();
}

class _InternalPaywallFooterViewState extends State<InternalPaywallFooterView> {
  MethodChannel? _channel;

  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{
      'offeringIdentifier': widget.offering?.identifier,
    };

    return Platform.isAndroid
        ? _buildAndroidPlatformViewLink(creationParams)
        : _buildUiKitView(creationParams);
  }

  UiKitView _buildUiKitView(Map<String, dynamic> creationParams) => UiKitView(
    viewType: InternalPaywallFooterView._viewType,
    layoutDirection: TextDirection.ltr,
    creationParams: creationParams,
    creationParamsCodec: const StandardMessageCodec(),
    onPlatformViewCreated: (id) {
      _channel = MethodChannel(
        'purchases_ui_flutter/PaywallFooterView/$id',
      );
      _channel?.setMethodCallHandler((call) async {
        if (call.method == 'onHeightChanged') {
          widget.onHeightChanged(call.arguments as double);
        }
      });
    },
  );

  PlatformViewLink _buildAndroidPlatformViewLink(
      Map<String, dynamic> creationParams,
      ) =>
      PlatformViewLink(
        viewType: InternalPaywallFooterView._viewType,
        surfaceFactory: (context, controller) => AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        ),
        onCreatePlatformView: (params) {
          _channel = MethodChannel(
            'purchases_ui_flutter/PaywallFooterView/${params.id}',
          );
          _channel?.setMethodCallHandler((call) async {
            if (call.method == 'onHeightChanged') {
              widget.onHeightChanged(call.arguments as double);
            }
          });
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: InternalPaywallFooterView._viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      );
}
