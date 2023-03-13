import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/service/httpservice.dart';
import 'package:shimmer/shimmer.dart';

import '../../httpmodel/appdetails_model.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget.regular('aboutus'.tr, fontFamily: "Poppins-Bold", fontSize: 20.sp),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: FutureBuilder<AppDetailsModel>(
            future: HttpService().getAppDetailsService(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget.regular('appname'.tr, fontFamily: "Poppins-Bold"),
                    TextWidget.regular(snapshot.data!.onlineMp3[0].appName, fontFamily: "Poppins-Medium"),
                    SizedBox(height: 10.h),
                    TextWidget.regular('appversion'.tr, fontFamily: "Poppins-Bold"),
                    TextWidget.regular(snapshot.data!.onlineMp3[0].appVersion, fontFamily: "Poppins-Medium"),
                    SizedBox(height: 10.h),
                    TextWidget.regular('appauthor'.tr, fontFamily: "Poppins-Bold"),
                    TextWidget.regular(snapshot.data!.onlineMp3[0].appAuthor, fontFamily: "Poppins-Medium"),
                    SizedBox(height: 10.h),
                    TextWidget.regular('appcontact'.tr, fontFamily: "Poppins-Bold"),
                    TextWidget.regular(snapshot.data!.onlineMp3[0].appContact, fontFamily: "Poppins-Medium"),
                    SizedBox(height: 10.h),
                    TextWidget.regular('appemail'.tr, fontFamily: "Poppins-Bold"),
                    TextWidget.regular(snapshot.data!.onlineMp3[0].appEmail, fontFamily: "Poppins-Medium"),
                    SizedBox(height: 10.h),
                    TextWidget.regular('appdevelopedby'.tr, fontFamily: "Poppins-Bold"),
                    TextWidget.regular(snapshot.data!.onlineMp3[0].appDevelopedBy, fontFamily: "Poppins-Medium"),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
