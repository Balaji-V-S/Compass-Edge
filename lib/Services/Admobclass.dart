// ignore_for_file: file_names

import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6556402405172089/1523129417';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6556402405172089/5866571249';
    }

    return null;
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6556402405172089/1964425617';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6556402405172089/2920044943';
    }

    return null;
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6556402405172089/3085935597';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6556402405172089/5793620296';
    }

    return null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded.'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load:$error');
    },
    onAdOpened: (ad) => debugPrint('Ad loaded'),
    onAdClosed: (ad) => debugPrint('Ad closed'),
  );
}
