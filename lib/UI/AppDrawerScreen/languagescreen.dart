import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Language/language_constant.dart';
import 'package:musicplayer/Constants/Language/language_model.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Constants/constant.dart';

import '../../main.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({Key? key}) : super(key: key);

  final RxInt selectedindex = 0.obs;

  @override
  Widget build(BuildContext context) {
    void changeLanguage(Language language) async {
      await setLocale(language.languageCode).then((val) async {
        MyApp.setLocale(context, val);
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextWidget.regular('language'.tr, fontFamily: "Poppins-Bold", fontSize: 20.sp),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: SizedBox(
          height: 300.h,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Language.languageList.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10.h,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Get.updateLocale(Locale(Language.languageList[index].languageCode,Language.languageList[index].countryCode));
                  // changeLanguage(Language.languageList[index].languageCode);
                  final snackBar = SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Row(
                      children: [
                        TextWidget.regular(Language.languageList[index].name,
                            fontSize: 20.sp, fontFamily: "Poppins-Regular", color: Get.theme.colorScheme.primary),
                        SizedBox(width: 8.w),
                        TextWidget.regular("languagesetsuccessfully".tr,
                            fontFamily: "Poppins-Medium", color: Get.theme.colorScheme.primary, fontSize: 15.sp),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(15.0),
                    dismissDirection: DismissDirection.startToEnd,
                    backgroundColor: shimmerGreen,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Language.languageList[index].id = selectedindex.value;
                  // selectedindex.value = index;
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                leading: TextWidget.regular(Language.languageList[index].flag, fontSize: 25.sp),
                title: TextWidget.regular(Language.languageList[index].name,
                    fontSize: 20.sp, textAlign: TextAlign.start, fontFamily: "Poppins-Regular"),
                // trailing: index == selectedindex.value
                //         ? SvgPicture.asset(
                //             'assets/icons/done.svg',
                //             height: 30.w,
                //             width: 30.w,
                //             color: Theme.of(context).colorScheme.primary,
                //           )
                //         : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
