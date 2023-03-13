import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';
import 'package:musicplayer/Controller/login_controller.dart';
import 'package:musicplayer/UI/LoginScreen/loginscreen.dart';

import '../../Constants/Custom_widget/textformfield.dart';
import '../../generated/l10n.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final LoginController logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 30.h, bottom: 20.h),
          child: Form(
            key: logincontroller.regformKey,
            child: Column(
              children: [
                TextWidget.regular('register'.tr, fontSize: 30.sp, fontFamily: "Poppins-Bold"),
                SizedBox(height: 20.h),
                TextFieldWidget(
                  borderRadius: 15.r,
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'name'.tr,
                  labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  style: TextStyle(fontSize: 19.sp, fontFamily: "Poppins-Medium"),
                  hintText: 'entername'.tr,
                  keyboardType: TextInputType.name,
                  controller: logincontroller.regname,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'nameisempty'.tr;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 15.h),
                TextFieldWidget(
                  borderRadius: 15.r,
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'emailaddress'.tr,
                  labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  style: TextStyle(fontSize: 19.sp, fontFamily: "Poppins-Medium"),
                  hintText: 'enteremail'.tr,
                  keyboardType: TextInputType.emailAddress,
                  controller: logincontroller.regemail,
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
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        splashRadius: 1.0,
                        onPressed: () {
                          logincontroller.passwordVisible.value = !logincontroller.passwordVisible.value;
                        },
                        icon: Icon(
                          !logincontroller.passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      obscureText: logincontroller.passwordVisible.value,
                      labelText: 'password'.tr,
                      labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                      style: TextStyle(fontSize: 19.sp, fontFamily: "Poppins-Medium"),
                      hintText: 'enterpassword'.tr,
                      keyboardType: TextInputType.text,
                      controller: logincontroller.regpass,
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
                SizedBox(height: 15.h),
                Obx(() {
                  return TextFieldWidget(
                      borderRadius: 15.r,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        splashRadius: 1.0,
                        onPressed: () {
                          logincontroller.conpasswordVisible.value = !logincontroller.conpasswordVisible.value;
                        },
                        icon: Icon(
                          !logincontroller.conpasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      obscureText: logincontroller.conpasswordVisible.value,
                      labelText: 'confirmpassword'.tr,
                      labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                      style: TextStyle(fontSize: 19.sp, fontFamily: "Poppins-Medium"),
                      hintText: 'enterpassword'.tr,
                      keyboardType: TextInputType.text,
                      controller: logincontroller.regconform,
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
                SizedBox(height: 15.h),
                TextFieldWidget(
                  borderRadius: 15.r,
                  prefixIcon: const Icon(Icons.call),
                  labelText: 'phoneno'.tr,
                  labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  style: TextStyle(fontSize: 19.sp, fontFamily: "Poppins-Medium"),
                  hintText: 'enterphone'.tr,
                  keyboardType: TextInputType.phone,
                  controller: logincontroller.regphone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phonenoisempty'.tr;
                      }
                      if (value.length != 10) {
                        return 'enterphonenoatleast'.tr;
                      }
                      return null;
                    }
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget.regular('alreadyhave'.tr, fontSize: 15.sp, fontFamily: "Poppins-Medium"),
                    SizedBox(width: 5.w),
                    InkWell(
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                        child: TextWidget.regular('login'.tr,
                            fontSize: 15.sp,
                            color: Get.theme.colorScheme.onPrimary,
                            fontFamily: "Poppins-Bold",
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 35.h),
                Center(
                    child: InkWell(
                  onTap: () async {
                    if (logincontroller.regpass.text == logincontroller.regconform.text) {
                      if (logincontroller.regformKey.currentState!.validate()) {
                        await logincontroller
                            .register(
                                email: logincontroller.regemail.text,
                                password: logincontroller.regpass.text,
                                phone: logincontroller.regphone.text,
                                name: logincontroller.regname.text)
                            .whenComplete(() {
                          Get.to(LoginScreen());
                        });
                      }
                    } else {
                      final snackBar = SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.error_outline),
                            SizedBox(width: 10.w),
                            TextWidget.regular('enterbothpassword'.tr, fontFamily: 'Poppins-Regular'),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(20.0),
                        dismissDirection: DismissDirection.startToEnd,
                        backgroundColor: Get.theme.colorScheme.onPrimary,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    // Get.back();
                  },
                  child: Container(
                    height: 60.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: TextWidget.regular('signup'.tr, color: Colors.white, fontFamily: "Poppins-Medium"),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
