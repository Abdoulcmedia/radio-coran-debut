import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/dynamic_link.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../httpmodel/getuserupdate_model.dart';
import '../service/httpservice.dart';

class UserController extends GetxController {
  String? userName;
  String? userEmail;
  String? userImage;
  String? userId;
  String? phone;
  final RxBool isguest = false.obs;

  RxBool isOnline = true.obs;
  Future<bool> hasNetwork() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');
    isguest.value = prefs.getBool('guest') ?? false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      isOnline.value = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline.value = false;
      return false;
    }
  }

  static const String appShareAndroid = 'https://play.google.com/store';
  static const String appShareIOS = 'https://www.apple.com/in/app-store/';

  @override
  Future<void> onInit() async {
    print("Initialial Link :::: 1111111");


    dynamicLink();
    hasNetwork();
    super.onInit();
  }

  Future getuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');
    isguest.value = prefs.getBool('guest') ?? false;
    print("This is value of guest :: ${prefs.getBool('guest')}");
    print("This is value of guest :: ${isguest.value}");
    if (userId != null) {
      await HttpService().getUserService(userId: userId).then((value) async {
        await prefs.setString('name', value.onlineMp3[0].name);
        await prefs.setString('email', value.onlineMp3[0].email);
        await prefs.setString('image', value.onlineMp3[0].userImage);
        await prefs.setString('phone', value.onlineMp3[0].phone);
        userName = prefs.getString('name');
        userEmail = prefs.getString('email');
        userImage = prefs.getString('image');
        phone = prefs.getString('phone');
        update();
      });
    }
  }

  String getAppShare() {
    if (Platform.isIOS) {
      return appShareIOS;
    } else {
      return appShareAndroid;
    }
  }

  Future<GetUserUpdateModel> getUpdataController({String? name, String? email, File? image, String? userid, String? phone}) async {
    return await HttpService().getUserUpdateService(userImage: image, userId: userid, email: email, name: name, phone: phone);
  }
}
