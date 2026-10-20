/// The mode used to host embedded RevenueCat views on Android.
///
/// By default, Flutter attempts to use Texture Layer Hybrid Composition, which
/// has the lowest performance overhead. Hybrid Composition is more expensive,
/// but avoids a Flutter engine issue that can stop native view frames from
/// reaching Flutter on some Android 10 devices.
///
/// See [RevenueCat/purchases-flutter#1954](https://github.com/RevenueCat/purchases-flutter/issues/1954)
/// and [flutter/flutter#160854](https://github.com/flutter/flutter/issues/160854).
enum AndroidPlatformViewMode {
  /// Attempts to use Texture Layer Hybrid Composition.
  ///
  /// This is the default and cheapest hosting mode. Flutter can fall back to
  /// Hybrid Composition when Texture Layer Hybrid Composition is unsupported.
  textureLayerHybridComposition,

  /// Uses Hybrid Composition.
  ///
  /// This has more performance overhead, but avoids the Flutter engine issue
  /// described in [flutter/flutter#160854](https://github.com/flutter/flutter/issues/160854).
  hybridComposition,
}
