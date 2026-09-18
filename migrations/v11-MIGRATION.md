# V11 API Migration Guide

## Error codes

`PurchasesErrorCode` now carries its numeric code explicitly and every RevenueCat SDK uses the same number for the same error.

- `PurchasesErrorCode.unknownNonNativeError` is removed. It only existed to keep the enum positions aligned with the iOS codes; referencing it is now a compile error. Use `PurchasesErrorCode.unknownError`.
- `PurchasesErrorCode.code` is the numeric code. `PurchasesErrorCode.fromCode(int)` returns the matching member, or `unknownError` when there is none.
- `.index` is no longer the wire code. Anything that used `PurchasesErrorCode.values[n]` or `.index` to talk to the native side must switch to `fromCode` and `.code`.
- `PurchasesErrorCode.invalidEmailError` (43) is new; it is raised on web.

`PurchasesErrorHelper.getErrorCode` and `PurchasesError.fromJson` keep working and now fall back to `unknownError` for any code they do not know, instead of returning whichever member sat at that position.
