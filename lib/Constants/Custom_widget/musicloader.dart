import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: Lottie.asset('assets/lottie/loader.json', height: 150.h, width: 150.w),
      ),
    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Get.theme.colorScheme.background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/nointernet.json', height: 150.h, width: 150.w),
            SizedBox(
              height: 5.h,
            ),
            TextWidget.regular('No Internet Connection', fontFamily: "Poppins-SemiBold"),
          ],
        ),
      ),
    );
  }
}
