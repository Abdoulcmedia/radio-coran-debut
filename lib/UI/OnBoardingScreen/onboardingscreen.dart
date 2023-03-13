import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/Controller/onboarding_controller.dart';

import '../../Constants/Custom_widget/textwidget.dart';
import '../LoginScreen/loginscreen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final OnboardingController onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green.shade100, Colors.green.shade300, Colors.green.shade600, Colors.green.shade800],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: PageView.builder(
                  controller: onboardingController.controller,
                  onPageChanged: (int index) {
                    onboardingController.currentindex.value = index;
                  },
                  itemCount: onboardinglist.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget.regular(onboardinglist[index].title,
                            textAlign: TextAlign.center, fontSize: 25.sp, fontFamily: "Poppins-Bold"),
                        SizedBox(height: 20.h),
                        onboardinglist[index].lottie,
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: TextWidget.regular(onboardinglist[index].description,
                              textAlign: TextAlign.center, fontSize: 20.sp, fontFamily: "Poppins-SemiBold"),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 30.h),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(onboardinglist.length, (index) => buildDot(index, context))),
                    GestureDetector(
                        onTap: () {
                          onboardingController.currentindex.value++;

                          if (onboardingController.currentindex.value != 3) {
                            onboardingController.controller.jumpToPage(onboardingController.currentindex.value);
                          }

                          if (onboardingController.currentindex.value == 3) {
                            Get.offAll(LoginScreen());
                          }
                        },
                        child: Container(
                          height: 40.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Center(
                            child: TextWidget.regular(
                              onboardingController.currentindex.value == onboardinglist.length - 1 ? 'Done' : 'Next',
                            ),
                          ),
                        )),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
