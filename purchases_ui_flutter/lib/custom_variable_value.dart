/// Converts a map of custom variables to a map of strings for native platform consumption.
///
/// This is used internally to convert [CustomVariableValue] objects to their string
/// representations before passing to native code. This approach ensures that when
/// new variable types are added, the conversion logic is centralized.
///
/// @nodoc
Map<String, String>? convertCustomVariablesToStrings(
  Map<String, CustomVariableValue>? customVariables,
) {
  if (customVariables == null) return null;
  return customVariables.map((key, value) => MapEntry(key, value.stringValue));
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
///     'level': CustomVariableValue.string('42'),
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
  const factory CustomVariableValue.string(String value) = StringCustomVariableValue;

  /// Returns the string representation of this value.
  String get stringValue;
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
