import 'package:meta/meta.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/models/entitlement_info_wrapper.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';

import 'custom_variable_value.dart';

/// Callback invoked when the user passes a checkpoint.
///
/// **Experimental, invite-only:** Checkpoints are not generally available. They
/// require access granted by RevenueCat and may change or be removed in a future
/// release without a major version bump.
@experimental
typedef CheckpointPassed = void Function(CheckpointResult result);

/// Per-call parameters for [RevenueCatUI.checkpoint].
///
/// **Experimental, invite-only:** Checkpoints are not generally available. They
/// require access granted by RevenueCat and may change or be removed in a future
/// release without a major version bump.
@experimental
final class CheckpointParams {
  /// Custom variables a checkpoint's targeting rules are evaluated against,
  /// readable as `custom.<key>`. They are also rendered by the presented
  /// paywall.
  final Map<String, CustomVariableValue>? customVariables;

  /// How the SDK presents the flow selected by the checkpoint.
  final FlowPresentationMode presentationMode;

  const CheckpointParams({
    this.customVariables,
    this.presentationMode = FlowPresentationMode.defaultMode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckpointParams &&
          presentationMode == other.presentationMode &&
          _mapEquals(customVariables, other.customVariables);

  @override
  int get hashCode => Object.hash(
        presentationMode,
        customVariables == null
            ? null
            : Object.hashAllUnordered(
                customVariables!.entries
                    .map((e) => Object.hash(e.key, e.value)),
              ),
      );

  @override
  String toString() =>
      'CheckpointParams(customVariables: $customVariables, presentationMode: $presentationMode)';
}

/// Controls how the SDK presents the flow selected by a checkpoint.
///
/// Uses a private constructor with static constants so that new values can
/// be added in the future without breaking existing code.
///
/// **Experimental, invite-only:** Checkpoints are not generally available. They
/// require access granted by RevenueCat and may change or be removed in a future
/// release without a major version bump.
@experimental
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
///
/// **Experimental, invite-only:** Checkpoints are not generally available. They
/// require access granted by RevenueCat and may change or be removed in a future
/// release without a major version bump.
@experimental
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
///
/// **Experimental, invite-only:** Checkpoints are not generally available. They
/// require access granted by RevenueCat and may change or be removed in a future
/// release without a major version bump.
@experimental
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
///
/// **Experimental, invite-only:** Checkpoints are not generally available. They
/// require access granted by RevenueCat and may change or be removed in a future
/// release without a major version bump.
@experimental
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
///
/// **Experimental, invite-only:** Checkpoints are not generally available. They
/// require access granted by RevenueCat and may change or be removed in a future
/// release without a major version bump.
@experimental
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
