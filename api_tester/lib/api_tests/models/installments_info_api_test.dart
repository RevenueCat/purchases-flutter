import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _InstallmentsInfoApiTest {
  void _checkConstructor(
    int commitmentPaymentsCount,
    int renewalCommitmentPaymentsCount,
    String? commitmentInstallmentPeriod,
    double? installmentBillingPrice,
    String? installmentBillingPriceString,
    String? commitmentTotalPeriod,
    double? commitmentTotalPrice,
    String? commitmentTotalPriceString,
    BillingPlanType? billingPlanType,
    Map<String, dynamic> json,
  ) {
    InstallmentsInfo installmentsInfo = InstallmentsInfo(
      commitmentPaymentsCount,
      renewalCommitmentPaymentsCount,
    );
    installmentsInfo = InstallmentsInfo(
      commitmentPaymentsCount,
      renewalCommitmentPaymentsCount,
      commitmentInstallmentPeriod: commitmentInstallmentPeriod,
      installmentBillingPrice: installmentBillingPrice,
      installmentBillingPriceString: installmentBillingPriceString,
      commitmentTotalPeriod: commitmentTotalPeriod,
      commitmentTotalPrice: commitmentTotalPrice,
      commitmentTotalPriceString: commitmentTotalPriceString,
      billingPlanType: billingPlanType,
    );
    InstallmentsInfo installmentsInfoFromJson = InstallmentsInfo.fromJson(json);
  }

  void _checkInstallmentsInfo(InstallmentsInfo installmentsInfo) {
    int commitmentPaymentsCount = installmentsInfo.commitmentPaymentsCount;
    int renewalCommitmentPaymentsCount =
        installmentsInfo.renewalCommitmentPaymentsCount;
    String? commitmentInstallmentPeriod =
        installmentsInfo.commitmentInstallmentPeriod;
    double? installmentBillingPrice = installmentsInfo.installmentBillingPrice;
    String? installmentBillingPriceString =
        installmentsInfo.installmentBillingPriceString;
    String? commitmentTotalPeriod = installmentsInfo.commitmentTotalPeriod;
    double? commitmentTotalPrice = installmentsInfo.commitmentTotalPrice;
    String? commitmentTotalPriceString =
        installmentsInfo.commitmentTotalPriceString;
    BillingPlanType? billingPlanType = installmentsInfo.billingPlanType;
  }

  void _checkBillingPlanType(BillingPlanType billingPlanType) {
    switch (billingPlanType) {
      case BillingPlanType.upFront:
      case BillingPlanType.monthly:
      case BillingPlanType.unknown:
        break;
    }
  }
}
