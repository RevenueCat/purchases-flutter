import 'dart:async';

import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/offering_wrapper.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';

import 'custom_variable_value.dart';

/// Callback invoked when the user passes a checkpoint.
typedef CheckpointPassed = void Function(CheckpointResult result);

/// Per-call parameters for [RevenueCatUI.checkpoint].
///
/// Checkpoints are an experimental, invite-only API and may change or be
/// removed in a future release without a major version bump.
final class CheckpointParams {
  /// Custom variables a checkpoint's targeting rules are evaluated against,
  /// readable as `custom.<key>`. They are also rendered by the presented
  /// paywall.
  final Map<String, CustomVariableValue>? customVariables;

  /// How the SDK presents the flow selected by the checkpoint.
  final FlowPresentationMode presentationMode;

  /// Presents the selected offering with app-owned UI. Null inherits the
  /// presenter captured from [RevenueCatUI.setPaywallPresenter] at call time.
  final PaywallPresenter? paywallPresenter;

  /// Uses the native presenter even when a global presenter is registered.
  /// Takes precedence over [paywallPresenter].
  final bool useNativePaywallPresenter;

  const CheckpointParams({
    this.customVariables,
    this.presentationMode = FlowPresentationMode.defaultMode,
    this.paywallPresenter,
    this.useNativePaywallPresenter = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckpointParams &&
          presentationMode == other.presentationMode &&
          paywallPresenter == other.paywallPresenter &&
          useNativePaywallPresenter == other.useNativePaywallPresenter &&
          _mapEquals(customVariables, other.customVariables);

  @override
  int get hashCode => Object.hash(
        presentationMode,
        paywallPresenter,
        useNativePaywallPresenter,
        customVariables == null
            ? null
            : Object.hashAllUnordered(
                customVariables!.entries
                    .map((e) => Object.hash(e.key, e.value)),
              ),
      );

  @override
  String toString() =>
      'CheckpointParams(customVariables: $customVariables, presentationMode: $presentationMode, paywallPresenter: $paywallPresenter, useNativePaywallPresenter: $useNativePaywallPresenter)';
}

/// Controls how the SDK presents the flow selected by a checkpoint.
///
/// Uses a private constructor with static constants so that new values can
/// be added in the future without breaking existing code.
final class FlowPresentationMode {
  final String _value;
  const FlowPresentationMode._(this._value);

  /// Lets the SDK choose how to present the flow.
  static const defaultMode = FlowPresentationMode._('DEFAULT');

  /// Presents the flow as a full-screen modal.
  static const modalFullScreen = FlowPresentationMode._('MODAL_FULL_SCREEN');

  /// Presents the flow as a sheet.
  static const modalSheet = FlowPresentationMode._('MODAL_SHEET');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlowPresentationMode && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value;
}

/// What a checkpoint reports once the user is allowed to continue.
final class CheckpointResult {
  /// What the user obtained in the flow the checkpoint presented. Null when
  /// there was nothing to present, such as an unconfigured identifier or no
  /// matching rule.
  final FlowResult? flow;

  /// Customer information after passing the checkpoint.
  final CustomerInfo customer;

  const CheckpointResult(this.flow, this.customer);

  /// @nodoc
  factory CheckpointResult.fromJson(Map<String, dynamic> json) {
    final flow = json['flow'];
    return CheckpointResult(
      flow == null
          ? null
          : FlowResult.fromJson(Map<String, dynamic>.from(flow)),
      CustomerInfo.fromJson(Map<String, dynamic>.from(json['customer'])),
    );
  }

  @override
  String toString() => 'CheckpointResult(flow: $flow, customer: $customer)';
}

/// What the user obtained while going through the flow a checkpoint presented.
final class FlowResult {
  /// The entitlements the user obtained. Empty when they obtained none.
  final List<ObtainedEntitlement> obtainedEntitlements;

  /// The products the user obtained. Empty when they obtained none.
  final List<ObtainedProduct> obtainedProducts;

  const FlowResult(this.obtainedEntitlements, this.obtainedProducts);

  /// @nodoc
  factory FlowResult.fromJson(Map<String, dynamic> json) => FlowResult(
        (json['obtainedEntitlements'] as List? ?? const [])
            .map(
              (e) => ObtainedEntitlement.fromJson(
                Map<String, dynamic>.from(e),
              ),
            )
            .toList(),
        (json['obtainedProducts'] as List? ?? const [])
            .map((e) => ObtainedProduct.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );

  @override
  String toString() =>
      'FlowResult(obtainedEntitlements: $obtainedEntitlements, obtainedProducts: $obtainedProducts)';
}

/// An entitlement the user obtained during a checkpoint.
final class ObtainedEntitlement {
  /// The entitlement as it stands after the checkpoint.
  final EntitlementInfo entitlementInfo;

  const ObtainedEntitlement(this.entitlementInfo);

  /// @nodoc
  factory ObtainedEntitlement.fromJson(Map<String, dynamic> json) =>
      ObtainedEntitlement(
        EntitlementInfo.fromJson(
          Map<String, dynamic>.from(json['entitlementInfo']),
        ),
      );

  @override
  String toString() => 'ObtainedEntitlement($entitlementInfo)';
}

/// A product the user obtained during a checkpoint.
final class ObtainedProduct {
  /// The product the user obtained.
  final StoreProduct product;

  const ObtainedProduct(this.product);

  /// @nodoc
  factory ObtainedProduct.fromJson(Map<String, dynamic> json) =>
      ObtainedProduct(
        StoreProduct.fromJson(Map<String, dynamic>.from(json['product'])),
      );

  @override
  String toString() => 'ObtainedProduct($product)';
}

bool _mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
  if (identical(a, b)) return true;
  if (a == null || b == null || a.length != b.length) return false;
  for (final entry in a.entries) {
    if (!b.containsKey(entry.key) || b[entry.key] != entry.value) return false;
  }
  return true;
}

/// Presents a checkpoint-selected offering. Dismiss the app-owned UI before
/// calling completion. Completion is honored at most once. A returned future
/// does not complete presentation; throwing or failing the future backs out.
typedef PaywallPresenter = FutureOr<void> Function(
  PaywallPresentationParams params,
  void Function(PaywallPresentationResult result) completion,
);

/// Parameters for an app-owned checkpoint paywall.
final class PaywallPresentationParams {
  final String checkpointIdentifier;
  final Map<String, CustomVariableValue> customVariables;
  final FlowPresentationMode presentationMode;
  final Offering offering;

  const PaywallPresentationParams({
    required this.checkpointIdentifier,
    required this.customVariables,
    required this.presentationMode,
    required this.offering,
  });

  /// @nodoc
  factory PaywallPresentationParams.fromJson(Map<String, dynamic> json) {
    final variables = <String, CustomVariableValue>{};
    (json['customVariables'] as Map? ?? const {}).forEach((key, value) {
      if (value is String) {
        variables[key as String] = CustomVariableValue.string(value);
      } else if (value is num) {
        variables[key as String] = CustomVariableValue.number(value.toDouble());
      } else if (value is bool) {
        variables[key as String] = CustomVariableValue.boolean(value);
      }
    });
    return PaywallPresentationParams(
      checkpointIdentifier: json['checkpointIdentifier'] as String,
      customVariables: variables,
      presentationMode: switch (json['presentationMode']) {
        'MODAL_FULL_SCREEN' => FlowPresentationMode.modalFullScreen,
        'MODAL_SHEET' => FlowPresentationMode.modalSheet,
        _ => FlowPresentationMode.defaultMode,
      },
      offering: Offering.fromJson(Map<String, dynamic>.from(json['offering'])),
    );
  }
}

/// How an app-owned checkpoint paywall ended. New values may be added.
final class PaywallPresentationResult {
  final String _value;
  const PaywallPresentationResult._(this._value);

  /// Continue after the native SDK synchronizes purchases.
  static const continued = PaywallPresentationResult._('CONTINUED');

  /// The user closed the paywall. Continue after purchase synchronization.
  static const closed = PaywallPresentationResult._('CLOSED');

  /// The user navigated back. Stop without invoking the checkpoint callback.
  static const navigatedBack = PaywallPresentationResult._('NAVIGATED_BACK');

  @override
  String toString() => _value;
}
