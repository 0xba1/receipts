import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:receipts/ads/preloaded_interstitial_ad.dart';

/// {@template ads}
/// Allows showing ads. A facade for "google mobile ads"
/// {@end_template}
class AdsController {
  /// {@macro ads}
  AdsController(MobileAds instance) : _instance = instance;

  final MobileAds _instance;

  PreloadedInterstitialAd? _preloadedAd;

  /// Disposes preloaded ad
  void dispose() {
    _preloadedAd?.dispose();
  }

  /// Initializes the injected [MobileAds.instance].
  Future<void> initialize() async {
    await _instance.initialize();
  }

  /// Starts preloading an ad to be used later.
  ///
  /// The work doesn't start immediately so that calling this doesn't have
  /// adverse effects (jank) during start of a new screen.
  void preloadAd() {
    _preloadedAd = PreloadedInterstitialAd(adUnitId: interstitialId);

    // Wait a bit so that calling at start of a new screen doesn't have
    // adverse effects on performance.
    Future<void>.delayed(const Duration(seconds: 1)).then((_) {
      return _preloadedAd!.load();
    });
  }

  /// Allows caller to take ownership of a [PreloadedInterstitialAd].
  ///
  /// If this method returns a non-null value, then the caller is responsible
  /// for disposing of the loaded ad.
  PreloadedInterstitialAd? takePreloadedAd() {
    final ad = _preloadedAd;
    _preloadedAd = null;
    return ad;
  }

  /// Interstitial ads ID
  static String get interstitialId => _productionInterstitialId;

  /// Production Interstial ads ID
  // ignore: unused_element
  static String get _productionInterstitialId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9406136958842407/9281538548';
    } else {
      throw UnsupportedError('Currently only android is supported');
    }
  }

  /// Test Interstial ads ID
  // ignore: unused_element
  static String get _testInterstitialId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      throw UnsupportedError('Currently only android is supported');
    }
  }
}
