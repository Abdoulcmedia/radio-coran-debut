import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/UI/AppDrawerScreen/profileupdatescreen.dart';
import 'package:musicplayer/theme/theme.dart';
import 'package:vocsy_esys_flutter_share/vocsy_esys_flutter_share.dart';
import '../../Constants/Custom_widget/cachednetworkimage.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Controller/login_controller.dart';
import '../../Controller/user_controller.dart';
import '../../httpmodel/appdetails_model.dart';
import '../../service/httpservice.dart';
import 'languagescreen.dart';
import 'aboutusscreen.dart';
import 'privacypolicyscreen.dart';
import '../DownloadScreen/downloadscreen.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController());
  final LoginController logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.4,
      elevation: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<UserController>(
                init: UserController(),
                builder: (logic) {
                  return Column(
                    children: [
                      SizedBox(height: 48.h),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5.w, color: Get.theme.colorScheme.onBackground),
                          shape: BoxShape.circle,
                        ),
                        child: ImageView(
                          imageUrl: userController.isguest.value ? image : userController.userImage!,
                          width: 128.0,
                          height: 128.0,
                          radius: 80.r,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextWidget.regular(
                        userController.isguest.value ? 'Guest' : userController.userName!,
                        fontFamily: "Poppins-Bold",
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 5.h),
                      TextWidget.regular(
                        userController.isguest.value ? '' : userController.userEmail!,
                        fontFamily: "Poppins-SemiBold",
                        fontSize: 15.sp,
                      ),
                    ],
                  );
                }),
            SizedBox(height: 20.h),
            const Divider(),
            if(!userController.isguest.value)  ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              onTap: () async {
                Get.to(ProfileUpdateScreen());
                Scaffold.of(context).closeDrawer();
              },
              tileColor: Colors.transparent,
              leading: SvgPicture.asset("assets/icons/profile.svg", color: Theme.of(context).iconTheme.color),
              title: TextWidget.regular('profile'.tr, fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
            ),
            if(!userController.isguest.value)const Divider(),
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              onTap: () async {
                Get.to(const ThemeChoice());
                Scaffold.of(context).closeDrawer();
              },
              tileColor: Colors.transparent,
              leading: SvgPicture.asset("assets/icons/theme.svg", color: Theme.of(context).iconTheme.color),
              title: TextWidget.regular('theme'.tr, fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
            ),
            const Divider(),
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              onTap: () async {
                Get.to(LanguageScreen());
              },
              tileColor: Colors.transparent,
              leading: SvgPicture.asset("assets/icons/language.svg", color: Theme.of(context).iconTheme.color),
              title: TextWidget.regular('language'.tr, fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
            ),
            if(!userController.isguest.value)const Divider(),
            if(!userController.isguest.value) ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              onTap: () {
                Get.to(DownloadScreen());
              },
              tileColor: Colors.transparent,
              leading: SvgPicture.asset(
                "assets/icons/download1.svg",
                color: Theme.of(context).iconTheme.color,
              ),
              title: TextWidget.regular('download'.tr, fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
            ),
            const Divider(),
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              onTap: () async {
                AppDetailsModel? data = await HttpService().getAppDetailsService();
                Get.to(PrivacyPolicyScreen(
                  data: data.onlineMp3[0].appPrivacyPolicy,
                ));
              },
              tileColor: Colors.transparent,
              leading: SvgPicture.asset(
                "assets/icons/privacy.svg",
                color: Theme.of(context).iconTheme.color,
              ),
              title: TextWidget.regular('privacypolicy'.tr, fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
            ),
            const Divider(),
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              onTap: () {
                Get.to(const AboutUsScreen());
              },
              tileColor: Colors.transparent,
              leading: SvgPicture.asset(
                "assets/icons/aboutus.svg",
                color: Theme.of(context).iconTheme.color,
                height: 25.h,
              ),
              title: TextWidget.regular('aboutus'.tr, fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
            ),
            const Divider(),
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              onTap: () async {
                VocsyShare.text('Music Player', /*userController.getAppShare() + */"https://vocsy.page.link/getApp", 'text/plain');
                // launchUrl(Uri.parse(''));
              },
              tileColor: Colors.transparent,
              leading: SvgPicture.asset("assets/icons/share1.svg", color: Theme.of(context).iconTheme.color),
              title: TextWidget.regular('shareapp'.tr, fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
            ),
            const Divider(),

            /// logout
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              tileColor: Colors.transparent,
              leading: SvgPicture.asset("assets/icons/logout.svg", color: Theme.of(context).iconTheme.color),
              title: TextWidget.regular(userController.isguest.value ? 'SignIn' : 'logout'.tr,
                  fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        child: SizedBox(
                      height: 150.h,
                      width: 100.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget.regular('areyousurelogout'.tr, fontFamily: "Poppins-Medium", fontSize: 20.sp),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 85.w,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Center(
                                      child: TextWidget.regular('cancel'.tr,
                                          fontFamily: "Poppins-Medium", fontSize: 15.sp, color: Colors.white),
                                    ),
                                  )),
                              SizedBox(
                                width: 10.w,
                              ),
                              InkWell(
                                onTap: () async {
                                  logincontroller.signOut();
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 85.w,
                                  decoration: BoxDecoration(
                                    color: Get.theme.colorScheme.onPrimary,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Center(
                                    child: TextWidget.regular('logout'.tr,
                                        fontFamily: "Poppins-Medium",
                                        fontSize: 15.sp,
                                        textAlign: TextAlign.center,
                                        color: Colors.white,
                                        maxLines: 1,
                                        textOverflow: TextOverflow.visible),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
                  },
                );
              },
            ),
            const Divider(),

            /// delete account
            userController.isguest.value
                ? SizedBox()
                : ListTile(
                    visualDensity: const VisualDensity(vertical: -2),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                              child: SizedBox(
                            height: 150.h,
                            width: 100.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget.regular('Are you sure delete account?', fontFamily: "Poppins-Medium", fontSize: 20.sp),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 85.w,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: TextWidget.regular('cancel'.tr,
                                                fontFamily: "Poppins-Medium", fontSize: 15.sp, color: Colors.white),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        logincontroller.deleteAccount().then((value) {
                                          if (value.isNotEmpty && value == "This user Is Deleted Please Contact Admin") {
                                            logincontroller.signOut();
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width: 85.w,
                                        decoration: BoxDecoration(
                                          color: Get.theme.colorScheme.onPrimary,
                                          borderRadius: BorderRadius.circular(10.r),
                                        ),
                                        child: Center(
                                          child: TextWidget.regular('delete',
                                              fontFamily: "Poppins-Medium",
                                              fontSize: 15.sp,
                                              textAlign: TextAlign.center,
                                              color: Colors.white,
                                              maxLines: 1,
                                              textOverflow: TextOverflow.visible),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ));
                        },
                      );
                    },
                    tileColor: Colors.transparent,
                    leading: SvgPicture.asset("assets/icons/delete_account.svg", color: Theme.of(context).iconTheme.color),
                    title:
                        TextWidget.regular('Delete Account', fontFamily: "Poppins-SemiBold", fontSize: 15.sp, textAlign: TextAlign.start),
                  ),
          ],
        ),
      ),
    );
  }
}
