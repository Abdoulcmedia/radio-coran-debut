import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController search = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  @override
  void onInit() {
    focusNode = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    super.onInit();
  }

  @override
  void dispose() {
    focusNode.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    search.clear();
    super.dispose();
  }
}
