import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/errors.dart';
import 'package:purchases_flutter/models/purchases_error.dart';

void main() {
  group('PurchasesError.fromJson', () {
    test('parses all fields', () {
      final json = {
        'code': 0,
        'message': 'An error occurred',
        'underlyingErrorMessage': 'Underlying error',
        'readableErrorCode': 'ERROR_CODE',
      };
      final info = PurchasesError.fromJson(json);
      const expected = PurchasesError(
        PurchasesErrorCode.unknownError,
        'An error occurred',
        'Underlying error',
        'ERROR_CODE',
      );
      expect(info, equals(expected));
    });
  });
} 
