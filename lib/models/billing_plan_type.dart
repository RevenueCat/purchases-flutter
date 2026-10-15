/// Enum indicating the billing plan type of an installment subscription.
/// iOS only.
enum BillingPlanType {
  /// The customer pays in full when purchasing the product.
  upFront,

  /// The customer pays in monthly installments.
  monthly,

  /// Unable to determine the billing plan type.
  unknown,
}
