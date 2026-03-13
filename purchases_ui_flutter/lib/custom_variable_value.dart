/// Converts a map of custom variables to a map preserving native types for
/// platform consumption.
///
/// String values are passed as strings, number values as doubles, and boolean
/// values as bools. This allows the native SDKs to use the correct type when
/// rendering paywall variables.
///
/// @nodoc
Map<String, dynamic>? convertCustomVariablesToNative(
  Map<String, CustomVariableValue>? customVariables,
) {
  if (customVariables == null) return null;
  return customVariables.map((key, value) => MapEntry(key, value.nativeValue));
}

/// A value type for custom paywall variables that can be passed to paywalls at runtime.
///
/// Custom variables allow developers to personalize paywall text with dynamic values.
/// Variables are defined in the RevenueCat dashboard and can be overridden at runtime.
///
/// ### Usage
/// ```dart
/// RevenueCatUI.presentPaywall(
///   customVariables: {
///     'player_name': CustomVariableValue.string('John'),
///     'level': CustomVariableValue.number(42),
///     'is_premium': CustomVariableValue.boolean(true),
///   },
/// );
/// ```
///
/// In the paywall text (configured in the dashboard), use the `custom.` prefix:
/// ```
/// Hello {{ custom.player_name }}!
/// ```
sealed class CustomVariableValue {
  const CustomVariableValue._();

  /// Creates a string custom variable value.
  const factory CustomVariableValue.string(String value) =
      StringCustomVariableValue;

  /// Creates a numeric custom variable value.
  const factory CustomVariableValue.number(double value) =
      NumberCustomVariableValue;

  /// Creates a boolean custom variable value.
  const factory CustomVariableValue.boolean(bool value) =
      BooleanCustomVariableValue;

  /// Returns the string representation of this value.
  String get stringValue;

  /// Returns the native value to pass to the platform channel.
  /// @nodoc
  Object get nativeValue;
}

/// A string custom variable value.
class StringCustomVariableValue extends CustomVariableValue {
  /// The string value.
  final String value;

  /// Creates a string custom variable value.
  const StringCustomVariableValue(this.value) : super._();

  @override
  String get stringValue => value;

  @override
  Object get nativeValue => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringCustomVariableValue &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'CustomVariableValue.string($value)';
}

/// A numeric custom variable value.
class NumberCustomVariableValue extends CustomVariableValue {
  /// The numeric value.
  final double value;

  /// Creates a numeric custom variable value.
  const NumberCustomVariableValue(this.value) : super._();

  @override
  String get stringValue =>
      value % 1.0 == 0 ? value.toInt().toString() : value.toString();

  @override
  Object get nativeValue => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberCustomVariableValue &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'CustomVariableValue.number($value)';
}

/// A boolean custom variable value.
class BooleanCustomVariableValue extends CustomVariableValue {
  /// The boolean value.
  final bool value;

  /// Creates a boolean custom variable value.
  const BooleanCustomVariableValue(this.value) : super._();

  @override
  String get stringValue => value.toString();

  @override
  Object get nativeValue => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooleanCustomVariableValue &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'CustomVariableValue.boolean($value)';
}
