import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musicplayer/Controller/user_controller.dart';

class ProfileController extends GetxController {
  final UserController userController = Get.put(UserController());

  TextEditingController username = TextEditingController();
  TextEditingController usergmail = TextEditingController();
  TextEditingController usermonumber = TextEditingController();

  final ImagePicker picker = ImagePicker();
  var selectedImageSize = ''.obs;
  File? selectedImagePath;
  RxBool profilebool = false.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath = File(pickedFile.path);
      selectedImageSize.value = "${((File(selectedImagePath!.path)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
      profilebool.value = true;
      profilebool.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if(userController.isguest.value == false){
    username.text = userController.userName!;
    usergmail.text = userController.userEmail!;
    usermonumber.text = userController.phone!;
    selectedImagePath;}
  }
}
