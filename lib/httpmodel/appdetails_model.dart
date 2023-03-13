// To parse this JSON data, do
//
//     final appDetailsModel = appDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AppDetailsModel appDetailsModelFromJson(String str) => AppDetailsModel.fromJson(json.decode(str));

String appDetailsModelToJson(AppDetailsModel data) => json.encode(data.toJson());

class AppDetailsModel {
  AppDetailsModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory AppDetailsModel.fromJson(Map<String, dynamic> json) => AppDetailsModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.packageName,
    required this.appName,
    required this.appLogo,
    required this.appVersion,
    required this.appAuthor,
    required this.appContact,
    required this.appEmail,
    required this.appWebsite,
    required this.appDescription,
    required this.appDevelopedBy,
    required this.appPrivacyPolicy,
    required this.publisherId,
    required this.interstitalAd,
    required this.interstitalAdId,
    required this.interstitalAdClick,
    required this.bannerAd,
    required this.bannerAdId,
    required this.appOpenAdId,
    required this.iosInterstitalAd,
    required this.iosInterstitalAdId,
    required this.iosInterstitalAdClick,
    required this.iosBannerAd,
    required this.iosBannerAdId,
    required this.iosAppOpenAdId,
    required this.songDownload,
  });

  final String packageName;
  final String appName;
  final String appLogo;
  final String appVersion;
  final String appAuthor;
  final String appContact;
  final String appEmail;
  final String appWebsite;
  final String appDescription;
  final String appDevelopedBy;
  final String appPrivacyPolicy;
  final String publisherId;
  final String interstitalAd;
  final String interstitalAdId;
  final String interstitalAdClick;
  final String bannerAd;
  final String bannerAdId;
  final String appOpenAdId;
  final String iosInterstitalAd;
  final String iosInterstitalAdId;
  final String iosInterstitalAdClick;
  final String iosBannerAd;
  final String iosBannerAdId;
  final String iosAppOpenAdId;
  final String songDownload;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    packageName: json["package_name"],
    appName: json["app_name"],
    appLogo: json["app_logo"],
    appVersion: json["app_version"],
    appAuthor: json["app_author"],
    appContact: json["app_contact"],
    appEmail: json["app_email"],
    appWebsite: json["app_website"],
    appDescription: json["app_description"],
    appDevelopedBy: json["app_developed_by"],
    appPrivacyPolicy: json["app_privacy_policy"],
    publisherId: json["publisher_id"],
    interstitalAd: json["interstital_ad"],
    interstitalAdId: json["interstital_ad_id"],
    interstitalAdClick: json["interstital_ad_click"],
    bannerAd: json["banner_ad"],
    bannerAdId: json["banner_ad_id"],
    appOpenAdId: json["app_open_ad_id"],
    iosInterstitalAd: json["ios_interstital_ad"],
    iosInterstitalAdId: json["ios_interstital_ad_id"],
    iosInterstitalAdClick: json["ios_interstital_ad_click"],
    iosBannerAd: json["ios_banner_ad"],
    iosBannerAdId: json["ios_banner_ad_id"],
    iosAppOpenAdId: json["ios_app_open_ad_id"],
    songDownload: json["song_download"],
  );

  Map<String, dynamic> toJson() => {
    "package_name": packageName,
    "app_name": appName,
    "app_logo": appLogo,
    "app_version": appVersion,
    "app_author": appAuthor,
    "app_contact": appContact,
    "app_email": appEmail,
    "app_website": appWebsite,
    "app_description": appDescription,
    "app_developed_by": appDevelopedBy,
    "app_privacy_policy": appPrivacyPolicy,
    "publisher_id": publisherId,
    "interstital_ad": interstitalAd,
    "interstital_ad_id": interstitalAdId,
    "interstital_ad_click": interstitalAdClick,
    "banner_ad": bannerAd,
    "banner_ad_id": bannerAdId,
    "app_open_ad_id": appOpenAdId,
    "ios_interstital_ad": iosInterstitalAd,
    "ios_interstital_ad_id": iosInterstitalAdId,
    "ios_interstital_ad_click": iosInterstitalAdClick,
    "ios_banner_ad": iosBannerAd,
    "ios_banner_ad_id": iosBannerAdId,
    "ios_app_open_ad_id": iosAppOpenAdId,
    "song_download": songDownload,
  };
}
