import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentindex = 0.obs;
  var controller = PageController();

  @override
  void onInit() {
    super.onInit();
    controller = PageController(initialPage: 0);
  }
}