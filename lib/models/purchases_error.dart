import 'package:equatable/equatable.dart';

import '../errors.dart';

/// Error information for purchases
class PurchasesError extends Equatable {
  /// The error code
  final PurchasesErrorCode code;
  /// The error message
  final String message;
  /// The underlying error message
  final String underlyingErrorMessage;
  /// iOS can return a readable error code null, because the construction
  /// of the error doesn't prevent it from being null. To be safe we default
  /// it to '' instead of making it nullable
  final String readableErrorCode;

  const PurchasesError(
    this.code,
    this.message,
    this.underlyingErrorMessage,
    this.readableErrorCode,
  );

  factory PurchasesError.fromJson(Map<String, dynamic> json) => PurchasesError(
    _purchasesErrorCodeFromJson(json['code'] as int),
    json['message'] as String,
    json['underlyingErrorMessage'] as String,
    json['readableErrorCode'] as String? ?? '',
  );

  @override
  List<Object?> get props => [
    code,
    message,
    underlyingErrorMessage,
    readableErrorCode,
  ];
}

_purchasesErrorCodeFromJson(int json) {
  if (json >= PurchasesErrorCode.values.length) {
    return PurchasesErrorCode.unknownError;
  }
  return PurchasesErrorCode.values[json];
}
