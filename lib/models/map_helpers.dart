import 'period_unit.dart';
import 'product_category.dart';
import 'store.dart';
import 'verification_result.dart';

VerificationResult verificationResultFromJson(dynamic value) {
  switch (value) {
    case 'NOT_REQUESTED':
      return VerificationResult.notRequested;
    case 'FAILED':
      return VerificationResult.failed;
    case 'VERIFIED':
      return VerificationResult.verified;
    case 'VERIFIED_ON_DEVICE':
      return VerificationResult.verifiedOnDevice;
    default:
      return VerificationResult.notRequested;
  }
}

Store storeFromJson(dynamic value) {
  switch (value) {
    case 'APP_STORE':
      return Store.appStore;
    case 'MAC_APP_STORE':
      return Store.macAppStore;
    case 'PLAY_STORE':
      return Store.playStore;
    case 'STRIPE':
      return Store.stripe;
    case 'PROMOTIONAL':
      return Store.promotional;
    case 'AMAZON':
      return Store.amazon;
    case 'RC_BILLING':
      return Store.rcBilling;
    case 'PADDLE':
      return Store.paddle;
    case 'EXTERNAL':
      return Store.externalStore;
    case null:
      return Store.unknownStore;
    default:
      return Store.unknownStore;
  }
}

ProductCategory? productCategoryFromJson(dynamic value) {
  switch (value) {
    case 'NON_SUBSCRIPTION':
      return ProductCategory.nonSubscription;
    case 'SUBSCRIPTION':
      return ProductCategory.subscription;
    default:
      return null;
  }
}

PeriodUnit periodUnitFromJson(dynamic value) {
  switch (value) {
    case 'DAY':
      return PeriodUnit.day;
    case 'WEEK':
      return PeriodUnit.week;
    case 'MONTH':
      return PeriodUnit.month;
    case 'YEAR':
      return PeriodUnit.year;
    default:
      return PeriodUnit.unknown;
  }
}
