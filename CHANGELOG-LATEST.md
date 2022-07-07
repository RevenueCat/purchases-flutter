## 4.0.0-beta.1

⚠️⚠️ This is a pre-release version. ⚠️⚠️
- `purchaserInfo` renamed to `customerInfo`
- Renamed `StoreProduct`, `StoreTransaction` and `StoreProductDiscount`. `package.product` to `package.storeProduct`
- Store enum has been moved into store.dart
- `setup` changed with `configure`

**Known issues:** Amazon support currently doesn't work correctly in the Live App Testing and production environments.
The purchase modal will not show correctly for Amazon in these environments.
