This project is a starting point for a Flutter application with a RevenueCat integration. For help 
getting started with, view our [online documentation](https://docs.revenuecat.com).

## Present a checkpoint paywall in a Flutter route

Set `paywallPresenter` and `errorDialogFactory` together to customize both for one checkpoint, including synchronization errors after the paywall completes. This example hosts `PaywallView` in an app-owned Flutter route; you can replace it with your own purchase UI.

```dart
VoidCallback showUpgradeCheckpoint(BuildContext context) {
  final navigator = Navigator.of(context);

  return RevenueCatUI.checkpoint(
    'upgrade',
    (result) {
      // Continue navigation after the native SDK passes the checkpoint.
    },
    params: CheckpointParams(
      paywallPresenter: (params, completion) async {
        var outcome = PaywallPresentationResult.closed;
        final route = MaterialPageRoute<PaywallPresentationResult>(
          fullscreenDialog: true,
          builder: (_) => Scaffold(
            body: PaywallView(
              offering: params.offering,
              customVariables: params.customVariables,
              displayCloseButton: true,
              onPurchaseCompleted: (customerInfo, transaction) {
                outcome = PaywallPresentationResult.continued;
              },
              onRestoreCompleted: (customerInfo) {
                outcome = PaywallPresentationResult.continued;
              },
              onDismiss: () => navigator.pop(outcome),
            ),
          ),
        );

        final result = await navigator.push(route);
        // Wait until the route's dismissal animation and UI removal finish.
        await route.completed;
        completion(result ?? PaywallPresentationResult.navigatedBack);
      },
      errorDialogFactory: (error) async {
        return const CheckpointErrorDialogOutcome.show(
          CheckpointErrorDialog(
            message: 'Please try again.',
            primaryButtonTitle: 'OK',
          ),
        );
      },
    ),
  );
}
```
