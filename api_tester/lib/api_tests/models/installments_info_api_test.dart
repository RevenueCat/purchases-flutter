import 'package:purchases_flutter/object_wrappers.dart';

// ignore_for_file: unused_element
// ignore_for_file: unused_local_variable
class _InstallmentsInfoApiTest {
  void _checkConstructor(
    int commitmentPaymentsCount,
    int renewalCommitmentPaymentsCount,
    Map<String, dynamic> json,
  ) {
    InstallmentsInfo installmentsInfo = InstallmentsInfo(
      commitmentPaymentsCount,
      renewalCommitmentPaymentsCount,
    );
    InstallmentsInfo installmentsInfoFromJson = InstallmentsInfo.fromJson(json);
  }

  void _checkInstallmentsInfo(InstallmentsInfo installmentsInfo) {
    int commitmentPaymentsCount = installmentsInfo.commitmentPaymentsCount;
    int renewalCommitmentPaymentsCount =
        installmentsInfo.renewalCommitmentPaymentsCount;
  }
}
