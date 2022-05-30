import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// {@template preload}
/// Holds a preloaded interstitial ad
/// {@end_template}
class PreloadedInterstitialAd {
  /// {@macro preload}
  PreloadedInterstitialAd({
    required String adUnitId,
    AdRequest? adRequest,
  })  : _adUnitId = adUnitId,
        _adRequest = adRequest ?? const AdRequest();
  final AdRequest _adRequest;

  InterstitialAd? _interstitialAd;

  final String _adUnitId;

  final _adCompleter = Completer<InterstitialAd>();

  ///
  Future<InterstitialAd> get ready => _adCompleter.future;

  /// Loads [InterstitialAd]
  Future<void> load() {
    assert(
      Platform.isAndroid || Platform.isIOS,
      'AdMob currently does not support ${Platform.operatingSystem}',
    );

    return InterstitialAd.load(
      adUnitId: _adUnitId,
      request: _adRequest,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {},
          );

          _adCompleter.complete(_interstitialAd);
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
          _adCompleter.completeError(err);
        },
      ),
    );
  }

  /// Disposes preloaded ad
  void dispose() {
    debugPrint('preloaded banner ad being disposed');
    _interstitialAd?.dispose();
  }
}
