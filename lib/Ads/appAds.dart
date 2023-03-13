import 'dart:convert';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:musicplayer/Constants/constant.dart';


String? getBannerAdUnitId() {
  if (Platform.isIOS) {
    return bannerIOS;
  } else if (Platform.isAndroid) {
    return bannerAndroid;
  }
  return null;
}

String bannerIOS = 'ca-app-pub-3940256099942544/2934735716';
String bannerAndroid = 'ca-app-pub-7142055990921479/8864591791';
String interstitialAndroid = 'ca-app-pub-3940256099942544/1033173712';
String interstitialIOS = 'ca-app-pub-3940256099942544/4411468910';
String openAdIdAndroid = 'ca-app-pub-3940256099942544/5662855259';
String openAdIdIOS = 'ca-app-pub-3940256099942544/5662855259';
InterstitialAd? interstitialAd;
bool openAdLoad = false;
AppOpenAd? appOpenAd;
// bool isShowingAd = false;



Future<void> initPlugin(context) async {
  final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
  // If the system can show an authorization request dialog
  if (status == TrackingStatus.notDetermined) {
    // Show a custom explainer dialog before the system dialog
    // await showCustomTrackingDialog(context);
    // Wait for dialog popping animation
    await Future.delayed(const Duration(milliseconds: 200));
    // Request system's tracking authorization dialog
    await AppTrackingTransparency.requestTrackingAuthorization();
  } else if (status == TrackingStatus.authorized) {
    await FacebookAuth.i.autoLogAppEventsEnabled(true);
  }

  await AppTrackingTransparency.getAdvertisingIdentifier();
}

getAdData() async {
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ['F8CA592EED08B230A7EA08E5805C1A6D']));
  try {
    final response = await http
        .post(Uri.parse(postApi), body: {'data': '{"method_name":"app_details","package_name":"com.vinodflutter.musicPlayerDemo"}'});
    if (response.statusCode == 200) {
      var finalResponse = jsonDecode(response.body);
      bannerIOS = finalResponse['ONLINE_MP3'][0]['ios_banner_ad_id'];
      bannerAndroid = finalResponse['ONLINE_MP3'][0]['banner_ad_id'];
      interstitialAndroid = finalResponse['ONLINE_MP3'][0]['interstital_ad_id'];
      interstitialIOS = finalResponse['ONLINE_MP3'][0]['ios_interstital_ad_id'];
      openAdIdAndroid = finalResponse['ONLINE_MP3'][0]['app_open_ad_id'];
      openAdIdIOS = finalResponse['ONLINE_MP3'][0]['ios_app_open_ad_id'];
    } else {
      print("Response of body ==${null}");
    }

    AdmobAds().loadAppOpenAd();
    AdmobAds().createInterstitialAd();
  } catch (e) {
    print('error in get data $e');
  }
}

String? intersTitleAd() {
  if (Platform.isIOS) {
    return interstitialIOS;
  } else if (Platform.isAndroid) {
    return interstitialAndroid;
  }
  return null;
}

String? openAd() {
  if (Platform.isIOS) {
    return openAdIdIOS;
  } else if (Platform.isAndroid) {
    return openAdIdAndroid;
  }
  return null;
}

class AdmobAds {
  Widget bannerAds() {
    final googleBannerAd = BannerAd(
      adUnitId: getBannerAdUnitId()!,
      size: AdSize.banner,
      listener:  BannerAdListener(onAdFailedToLoad: (ad, e){
      }),
      request: AdRequest(),
    )..load();
    return Container(
      alignment: Alignment.bottomCenter,
      width: googleBannerAd.size.width.toDouble(),
      height: googleBannerAd.size.height.toDouble(),
      child: AdWidget(ad: googleBannerAd),
    );
  }

  loadAppOpenAd() {
    AppOpenAd.load(
        adUnitId: openAd()!, //Your ad Id from admob
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
            onAdLoaded: (ad) {
              appOpenAd = ad;
              openAdLoad = true;
              print('open add loaded $openAdLoad');
            },
            onAdFailedToLoad: (error) {
              print('Ads load error====$error');
            }),
        orientation: AppOpenAd.orientationPortrait);
  }

  /// Interstitial Ads

  int maxFailedLoadAttempts = 3;

  static AdRequest request = const AdRequest(
    keywords: ['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? createInterstitialAd() {
    try {
      InterstitialAd.load(
          adUnitId: intersTitleAd()!,
          request: request,
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              interstitialAd = ad;
              print('add loaded');
              // _interstitialAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
              print('add loaded error $error');
            },
          ));
    } catch (e) {
      print('add loaded error $e');
    }
    return null;
  }

  /// Show IntertitialAd
  void showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');

        ad.dispose();

        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');

        ad.dispose();

        createInterstitialAd();
      },
    );
    interstitialAd!.show();

    interstitialAd = null;
  }
}
