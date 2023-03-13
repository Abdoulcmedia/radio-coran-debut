import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Controller/user_controller.dart';
import 'package:musicplayer/UI/RegisterScreen/registerscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/Custom_widget/textformfield.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Constants/constant.dart';
import '../../Controller/login_controller.dart';
import '../../generated/l10n.dart';
import '../BottomNavigatorBar/bottomnavigatorbar.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController());
  final LoginController logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: logincontroller.loginformKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [

                  Container(
                    height: 350.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(330.r)),
                      image: const DecorationImage(
                        image: AssetImage('assets/image/imagesguitar.jfif'),
                        fit: BoxFit.cover,
                      ),
                    ),


                  ),
                  Obx(() {
                    userController.isguest.value;
                    return GestureDetector(
                      onTap: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        userController.isguest.value = !userController.isguest.value;
                        prefs.setBool('guest', true);
                        userController.getuser().whenComplete(() => Get.offAll(MyBottomNavigationBar()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Container(
                          height: 42.r,
                          width: 42.r,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              "skip".tr,
                              style: const TextStyle(color: Colors.black, fontFamily: "Poppins-SemiBold"),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget.regular('welcome'.tr, fontSize: 20.sp, fontFamily: "Poppins-Bold"),
                    SizedBox(height: 20.h),
                    TextFieldWidget(
                      borderRadius: 15.r,
                      labelText: 'email'.tr,
                      labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                      prefixIcon: const Icon(Icons.email),
                      style: TextStyle(fontSize: 18.sp, fontFamily: "Poppins-Medium"),
                      hintText: 'enteremail'.tr,
                      keyboardType: TextInputType.emailAddress,
                      controller: logincontroller.useremail,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'emailisnotempty'.tr;
                        }
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'entervalidemail'.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    Obx(() {
                      return TextFieldWidget(
                          borderRadius: 15.r,
                          labelText: 'password'.tr,
                          labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                          controller: logincontroller.password,
                          prefixIcon: const Icon(Icons.lock),
                          obscureText: logincontroller.passwordVisible.value,
                          suffixIcon: IconButton(
                            splashRadius: 1.0,
                            onPressed: () {
                              logincontroller.passwordVisible.value = !logincontroller.passwordVisible.value;
                            },
                            icon: Icon(
                              !logincontroller.passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                          style: TextStyle(fontSize: 18.sp, fontFamily: "Poppins-Medium"),
                          hintText: 'enterpassword'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enterpassword'.tr;
                            }
                            if (value.length <= 5) {
                              return 'enterpasswordatleast'.tr;
                            }
                            return null;
                          });
                    }),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget.regular('createanaccount'.tr, fontSize: 15.sp, fontFamily: "Poppins-Medium"),
                        SizedBox(width: 5.w),
                        InkWell(
                            onTap: () {
                              Get.to(RegisterScreen());
                            },
                            child: TextWidget.regular('signup'.tr,
                                fontSize: 15.sp,
                                color: Get.theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins-Bold")),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Center(
                        child: InkWell(
                      onTap: () async {
                        if (logincontroller.loginformKey.currentState!.validate()) {
                          showLoader(context);
                          print("Enter Position :: 00");
                          await logincontroller
                              .signIn(email: logincontroller.useremail.text, password: logincontroller.password.text).whenComplete(() {
                            hideLoader(context);
                            Get.offAll(MyBottomNavigationBar());
                          });

                        }
                      },
                      child: Container(
                        height: 55.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Center(
                          child: TextWidget.regular('login'.tr, color: Colors.white, fontFamily: "Poppins-Medium"),
                        ),
                      ),
                    )),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () async {
                              await logincontroller.googleSignIn();
                            },
                            child: Container(
                              height: 50.r,
                              width: 50.r,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(width: 1.w, color: Theme.of(context).colorScheme.onSecondary),
                              ),
                              child: Center(
                                child: SvgPicture.asset("assets/icons/googleicon.svg", height: 45.h),
                              ),
                            )),
                        SizedBox(width: 20.w),
                        InkWell(
                            onTap: () async {
                              await logincontroller.facebookSignIn();
                            },
                            child: Container(
                              height: 50.r,
                              width: 50.r,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.r),
                                border: Border.all(width: 1.w, color: Theme.of(context).colorScheme.onSecondary),
                              ),
                              child: Center(
                                child: SvgPicture.asset("assets/icons/facebook.svg", height: 45.h),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
