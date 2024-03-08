import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _PurchasesErrorApiTest {
  void _checkFromJsonFactory(Map<String, dynamic> json) {
    PurchasesError error = PurchasesError.fromJson(json);
  }

  void _checkToJson(PurchasesError error) {
    Map<String, dynamic> json = error.toJson();
  }

  void _checkConstructor(
    PurchasesErrorCode code,
    String message,
    String underlyingErrorMessage,
    String readableErrorCode,
  ) {
    PurchasesError error = PurchasesError(
        code, message, underlyingErrorMessage, readableErrorCode);
  }

  void _checkProperties(PurchasesError purchasesError) {
    PurchasesErrorCode code = purchasesError.code;
    String message = purchasesError.message;
    String underlyingErrorMessage = purchasesError.underlyingErrorMessage;
    String readableErrorCode = purchasesError.readableErrorCode;
  }
}
