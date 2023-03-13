import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/Controller/profile_controller.dart';
import '../../Constants/Custom_widget/cachednetworkimage.dart';
import '../../Constants/Custom_widget/textformfield.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Controller/search_controller.dart';
import '../../Controller/user_controller.dart';

class ProfileUpdateScreen extends StatelessWidget {
  ProfileUpdateScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());
  final UserController userController = Get.put(UserController());
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextWidget.regular('profile'.tr, fontWeight: FontWeight.bold, fontSize: 25.sp, fontFamily: "Poppins-Bold"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 45.h, left: 15.w, right: 15.w),
          child: KeyboardVisibilityBuilder(builder: (context, iskey) {
            if (!iskey) {
              searchController.focusNode.unfocus();
              searchController.focusNode2.unfocus();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(children: [
                  Obx(() {
                    profileController.profilebool.value;
                    return profileController.selectedImagePath != null
                        ? DottedBorder(
                            radius: Radius.circular(58.r),
                            borderType: BorderType.RRect,
                            color: Theme.of(context).colorScheme.onBackground,
                            dashPattern: const [8, 4],
                            strokeWidth: 2,
                            child: CircleAvatar(
                              radius: 58.r,
                              backgroundImage: FileImage(File(profileController.selectedImagePath!.path)),
                            ),
                          )
                        : DottedBorder(
                            radius: Radius.circular(58.r),
                            color: Theme.of(context).colorScheme.onBackground,
                            borderType: BorderType.RRect,
                            dashPattern: const [8, 4],
                            strokeWidth: 2,
                            child: CircleAvatar(
                              radius: 58.r,
                              child: ImageView(
                                imageUrl: userController.isguest.value ? image : userController.userImage!,
                                radius: 60.r,
                                height: 120.h,
                                width: 120.w,
                              ),
                            ),
                          );
                  }),
                  Positioned.fill(
                    bottom: 10,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          profileController.getImage(ImageSource.gallery);
                        },
                        child: CircleAvatar(
                          radius: 15.r,
                          backgroundColor: Colors.grey.shade400,
                          child: SvgPicture.asset("assets/icons/camera.svg",color: Get.theme.iconTheme.color)
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 20.h),
                TextFieldWidget(
                  borderRadius: 15.r,
                  labelText: 'username'.tr,
                  labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  prefixIcon: const Icon(Icons.person),
                  style: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  hintText: 'enterusername'.tr,
                  keyboardType: TextInputType.name,
                  controller: profileController.username,
                  focusNode: searchController.focusNode,
                  autofocus: false,
                ),
                SizedBox(height: 20.h),
                TextFieldWidget(
                  borderRadius: 15.r,
                  labelText: 'email'.tr,
                  labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  prefixIcon: const Icon(Icons.email),
                  style: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  hintText: 'enteremail'.tr,
                  keyboardType: TextInputType.emailAddress,
                  enable: false,
                  controller: profileController.usergmail,
                ),
                SizedBox(height: 20.h),
                TextFieldWidget(
                  borderRadius: 15.r,
                  labelText: 'phone'.tr,
                  prefixIcon: const Icon(Icons.phone),
                  labelstyle: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  style: TextStyle(fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                  hintText: 'enterphone'.tr,
                  keyboardType: TextInputType.phone,
                  controller: profileController.usermonumber,
                  focusNode: searchController.focusNode2,
                  autofocus: false,
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () {
                    userController
                        .getUpdataController(
                            name: profileController.username.text,
                            email: userController.userEmail,
                            userid: userController.userId,
                            phone: profileController.usermonumber.text,
                            image: profileController.selectedImagePath)
                        .whenComplete(() {
                      UserController().update();
                      userController.getuser();
                      final snackBar = SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.task_alt, color: Get.theme.iconTheme.color),
                            SizedBox(width: 10.w),
                            TextWidget.regular('profileupdatesuccessfully'.tr,
                                fontFamily: "Poppins-Medium", color: Get.theme.colorScheme.primary),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(15.0),
                        dismissDirection: DismissDirection.startToEnd,
                        backgroundColor: shimmerGreen,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: Container(
                    height: 50.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: TextWidget.regular('update'.tr, color: Colors.white, fontFamily: "Poppins-Medium"),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
