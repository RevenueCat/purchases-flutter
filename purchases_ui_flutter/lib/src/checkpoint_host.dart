import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../checkpoint.dart';
import '../checkpoint_error_presenter.dart';
import '../custom_variable_value.dart';
import 'checkpoint_session.dart';

final _callIdPrefix =
    '${DateTime.now().microsecondsSinceEpoch}-${Random().nextInt(1 << 30)}';
var _nextCallId = 0;

/// @nodoc
void Function() presentCheckpointWithAppErrors(
  String identifier,
  CheckpointPassed onPassed,
  CheckpointParams params,
) {
  final presenter = params.errorPresenter!;
  if (!presenter.context.mounted) {
    throw FlutterError('The checkpoint error presenter context is unmounted.');
  }
  final navigator = Navigator.of(presenter.context, rootNavigator: true);
  final controller = _CheckpointHostController(
    navigator: navigator,
    identifier: identifier,
    variables: convertCustomVariablesToNative(params.customVariables),
    mode: params.presentationMode,
    present: presenter.present,
    onPassed: onPassed,
    themes: InheritedTheme.capture(
      from: presenter.context,
      to: navigator.context,
    ),
  )..start();
  return controller.session.cancel;
}

final class _CheckpointHostController {
  static const _mainChannel = MethodChannel('purchases_ui_flutter');
  final NavigatorState navigator;
  final String identifier;
  final Map<String, dynamic>? variables;
  final FlowPresentationMode mode;
  final CapturedThemes themes;
  final Future<void> Function(CheckpointErrorRequest) present;
  final String callId = '$_callIdPrefix-${_nextCallId++}';
  final bool _isIOS = defaultTargetPlatform == TargetPlatform.iOS;
  late final CheckpointSession session;
  _HostRoute? _host;
  bool _closing = false;
  Future<void>? _closeFuture;

  _CheckpointHostController({
    required this.navigator,
    required this.identifier,
    required this.variables,
    required this.mode,
    required this.present,
    required CheckpointPassed onPassed,
    required this.themes,
  }) {
    session = CheckpointSession(
      callId: callId,
      onPassed: onPassed,
      waitsForFinished: _isIOS,
      errorContext: () async {
        if (_isIOS) return _host!.context;
        final host = _pushHost(flow: false);
        await host.ready.future;
        if (!session.isActive) return navigator.context;
        await session.channel.invokeMethod<void>('showErrorHost');
        WidgetsBinding.instance.scheduleFrame();
        await WidgetsBinding.instance.endOfFrame;
        return host.context;
      },
      presentError: (request) async {
        try {
          await present(request);
        } finally {
          if (!_isIOS) await _closeHost();
        }
      },
      closeHost: _closeHost,
    );
  }

  void start() {
    unawaited(() async {
      try {
        if (_isIOS) {
          final available = await _mainChannel.invokeMethod<bool>(
            'isCheckpointErrorPresenterAvailable',
          );
          if (!session.isActive) return;
          if (available != true) {
            throw UnsupportedError(
              'App-presented checkpoint errors require an iOS build with the '
              'embedded checkpoint SPI. See the experimental checkpoint setup.',
            );
          }
          _pushHost(flow: true);
        } else {
          if (!session.isActive) return;
          await _mainChannel.invokeMethod<void>(
            'startCheckpointWithErrorPresenter',
            {
              'callId': callId,
              'identifier': identifier,
              'customVariables': variables,
              'presentationMode': mode.toString(),
            },
          );
        }
      } catch (error, stack) {
        session.cancel();
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stack,
            library: 'purchases_ui_flutter',
            context: ErrorDescription('while starting a checkpoint'),
          ),
        );
      }
    }());
  }

  _HostRoute _pushHost({required bool flow}) {
    final existing = _host;
    if (existing != null) return existing;
    final host = _HostRoute();
    _host = host;
    Widget builder(BuildContext context) => themes.wrap(
          _CheckpointHostView(
            host: host,
            flow: flow,
            session: session,
            creationParams: {
              'callId': callId,
              'identifier': identifier,
              'customVariables': variables,
            },
            onDispose: () {
              if (!host.disposed.isCompleted) host.disposed.complete();
              if (!_closing) session.cancel();
            },
          ),
        );
    host.route = !flow
        ? PageRouteBuilder<void>(
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
            pageBuilder: (context, _, __) => builder(context),
          )
        : mode == FlowPresentationMode.modalFullScreen
            ? MaterialPageRoute<void>(
                fullscreenDialog: true,
                builder: builder,
              )
            : ModalBottomSheetRoute<void>(
                builder: (context) => FractionallySizedBox(
                  heightFactor: 0.9,
                  child: builder(context),
                ),
                capturedThemes: themes,
                isScrollControlled: true,
                useSafeArea: true,
                // Explicit close/native back remain available. Dragging a
                // platform view can otherwise dismiss during an app dialog.
                enableDrag: false,
                isDismissible: false,
              );
    unawaited(navigator.push<void>(host.route));
    return host;
  }

  Future<void> _closeHost() {
    if (_closing) return _closeFuture!;
    final host = _host;
    if (host == null) return Future<void>.value();
    _closing = true;
    return _closeFuture = () async {
      try {
        if (!_isIOS) {
          try {
            await session.channel.invokeMethod<void>('hideErrorHost');
          } on MissingPluginException {
            // Native already removed the session during activity/engine teardown.
            if (session.isActive) rethrow;
          }
        }
      } finally {
        if (!host.ready.isCompleted) host.ready.complete();
        if (navigator.mounted && host.route.isActive) {
          navigator.removeRoute(host.route);
        }
        // removeRoute does not complete Navigator.push on Flutter 3.22.
        // Route.completed waits until its overlay entries have been disposed.
        await host.route.completed;
        _host = null;
        _closing = false;
        _closeFuture = null;
      }
    }();
  }
}

final class _HostRoute {
  late TransitionRoute<void> route;
  late BuildContext context;
  final ready = Completer<void>();
  final disposed = Completer<void>();
}

class _CheckpointHostView extends StatefulWidget {
  final _HostRoute host;
  final bool flow;
  final CheckpointSession session;
  final Map<String, dynamic> creationParams;
  final VoidCallback onDispose;

  const _CheckpointHostView({
    required this.host,
    required this.flow,
    required this.session,
    required this.creationParams,
    required this.onDispose,
  });

  @override
  State<_CheckpointHostView> createState() => _CheckpointHostViewState();
}

class _CheckpointHostViewState extends State<_CheckpointHostView> {
  final _navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        // Keep compatibility with Flutter 3.22.
        // ignore: deprecated_member_use
        onPopInvoked: (didPop) {
          if (didPop) return;
          final navigator = _navigator.currentState;
          if (navigator != null && navigator.canPop()) {
            unawaited(navigator.maybePop());
          } else if (widget.flow) {
            widget.session.cancel();
          }
        },
        child: Navigator(
          key: _navigator,
          onGenerateRoute: (_) => PageRouteBuilder<void>(
            transitionDuration: Duration.zero,
            pageBuilder: (context, _, __) {
              widget.host.context = context;
              if (!widget.host.ready.isCompleted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!widget.host.ready.isCompleted) {
                    widget.host.ready.complete();
                  }
                });
              }
              if (!widget.flow) return const SizedBox.expand();
              return Material(
                child: SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: IconButton(
                          tooltip: MaterialLocalizations.of(context)
                              .closeButtonTooltip,
                          onPressed: widget.session.cancel,
                          icon: const Icon(Icons.close),
                        ),
                      ),
                      Expanded(
                        child: UiKitView(
                          viewType: 'com.revenuecat.purchasesui/CheckpointView',
                          layoutDirection: TextDirection.ltr,
                          creationParams: widget.creationParams,
                          creationParamsCodec: const StandardMessageCodec(),
                          onPlatformViewCreated: (_) {
                            if (!widget.session.isActive) return;
                            unawaited(
                              widget.session.channel
                                  .invokeMethod<void>('start')
                                  .catchError((Object error, StackTrace stack) {
                                widget.session.cancel();
                                FlutterError.reportError(
                                  FlutterErrorDetails(
                                    exception: error,
                                    stack: stack,
                                    library: 'purchases_ui_flutter',
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }
}
