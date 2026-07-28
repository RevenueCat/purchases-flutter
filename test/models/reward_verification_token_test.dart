import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/models/reward_verification_token.dart';

void main() {
  group('RewardVerificationToken.fromMap', () {
    test('parses all fields', () {
      final token = RewardVerificationToken.fromMap({
        'customData': 'custom-data',
        'clientTransactionId': 'client-transaction-id',
        'appUserID': 'app-user-id',
      });
      expect(token.customData, 'custom-data');
      expect(token.clientTransactionId, 'client-transaction-id');
      expect(token.appUserID, 'app-user-id');
    });
  });
}
