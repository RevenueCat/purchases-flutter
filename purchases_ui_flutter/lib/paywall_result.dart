/// Possible values for the result of a paywall presentation.
enum PaywallResult {
  /// Only returned when using [RevenueCatUI.presentPaywallIfNeeded]. Returned
  /// if the paywall was not presented.
  notPresented,
  /// Returned when the paywall was presented and the user cancelled without
  /// executing an action.
  cancelled,
  /// Returned when the paywall was presented and an error occurred performing
  /// an operation.
  error,
  /// Returned when the paywall was presented and the user successfully
  /// purchased.
  purchased,
  /// Returned when the paywall was presented and the user successfully
  /// restored.
  restored
}
