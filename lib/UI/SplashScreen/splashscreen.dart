import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Ads/appAds.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/Constants/dynamic_link.dart';
import 'package:musicplayer/UI/OnBoardingScreen/onboardingscreen.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Controller/user_controller.dart';
import '../BottomNavigatorBar/bottomnavigatorbar.dart';
import '../DownloadScreen/downloadscreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = Get.put(UserController());

  Future<void> initialLinkFunction() async {
    print("Function Calling");
    initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    print("Function Calling value = ${initialLink!}");
    print("Function Calling value2 = ${initialLink!.link}");
  }
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      getDeviceInfo();
    }

    initialLinkFunction().whenComplete(() {
      print("Init DynamicLink");
      initPlugin(context);
      if (initialLink == null) {
        Future.delayed(const Duration(seconds: 3), () {
          if (userController.isOnline.value) {
            userController.getuser().whenComplete(() {
              print("THis is getUserApp :: ${userController.isguest.value}");
              Get.off(() => userController.isguest.value || userController.userId != null   ? MyBottomNavigationBar() : OnBoardingScreen());
            });
          } else {
            Get.offAll(DownloadScreen());
          }
        });
      } else {
        print("Function Calling value = ${initialLink!.link}");
        initDynamicLinks();
      }
    });

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green.shade100, Colors.green.shade300, Colors.green.shade600, Colors.green.shade800],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  'assets/image/MusicPro.png',
                  height: 200.h,
                  width: 200.w,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextWidget.regular('Music Player', fontSize: 30.0.sp, fontFamily: "Poppins-Medium"),
            ],
          ),
        ),
      ),
    ));
  }
}
