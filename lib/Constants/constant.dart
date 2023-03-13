import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Controller/onboarding_controller.dart';
import 'Custom_widget/musicloader.dart';

String postApi = "https://vocsyinfotech.in/envato/cc/flutter_musicplayer/api.php";
String image = 'https://vocsyinfotech.in/envato/cc/flutter_musicplayer/images/add-image.png';

String appShareAndroid = 'https://play.google.com/store';
String appShareIOS = 'https://www.apple.com/in/app-store/';

bool isAndroidVersionUp13 = false;

Color green = Colors.green;
Color shimmerGreen = Colors.green.shade400;
Color shimmerLightGreen = Colors.green.shade100;
Color green800 = Colors.green.shade800;
Color green600 = Colors.green.shade600;
Color green400 = Colors.green.shade400;
Color green300 = Colors.green.shade300;
Color green200 = Colors.green.shade200;

final OnboardingController onboardingController = Get.put(OnboardingController());

void showLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => const Loading(),
  );
}


void hideLoader(BuildContext context) {
  Navigator.of(context).pop(const Loading());
}

snackbar({title, message}) {
  return Get.snackbar(title, message, backgroundColor: shimmerGreen, duration: const Duration(seconds: 2));
}

List<Onboarding> onboardinglist = [
  Onboarding(
      title: "Welcome to Music Player",
      lottie: Lottie.asset('assets/lottie/image1.json'),
      description: "Music your emotions and make\n you to fool happy."),
  Onboarding(
      title: "Enjoy Music",
      lottie: Lottie.asset('assets/lottie/image2.json'),
      description: "Massive music for you to listen to,\n enjoy each moment of music."),
  Onboarding(
      title: "Music is Life",
      lottie: Lottie.asset('assets/lottie/image3.json'),
      description: "Music, when soft voices die,\n vibrates in the memory."),
];

class Onboarding {
  final String title;
  final Widget lottie;
  final String description;

  Onboarding({required this.title, required this.lottie, required this.description});
}

Container buildDot(int index, BuildContext context) {
  return Container(
    margin: EdgeInsets.only(right: 10.w),
    height: 13.r,
    width: 13.r,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r), color: onboardingController.currentindex.value == index ? Colors.white : Colors.grey),
  );
}

getDeviceInfo() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo = await deviceInfoPlugin.deviceInfo;
  final allInfo = deviceInfo.data;
  print("App Ver : ${int.parse(allInfo['version']["release"])}");
  if (int.parse(allInfo['version']["release"]) >= 13) {
    isAndroidVersionUp13 = true;
  } else {
    isAndroidVersionUp13 = false;
  }
}
