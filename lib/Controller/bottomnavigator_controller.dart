import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/Controller/search_controller.dart';
import 'package:musicplayer/UI/BottomNavigatorBar/homescreen.dart';
import 'package:musicplayer/UI/BottomNavigatorBar/searchscreen.dart';

import '../UI/BottomNavigatorBar/favourite_screen.dart';

class BottomNavigationController extends GetxController {
  final SearchController searchController = Get.put(SearchController());

  RxInt selectedIndex = 0.obs;
  List<Widget> tabPage = [
    HomeScreen(),
    SearchScreen(),
    FavouriteScreen(),
  ];

  // var tabs = [
  //   BottomNavigationBarItem(
  //       activeIcon: SvgPicture.asset("assets/icons/home.svg", color:green),
  //       icon: SvgPicture.asset("assets/icons/homeoutline.svg", color:Get.theme.iconTheme.color),
  //       label: ''),
  //   BottomNavigationBarItem(
  //       activeIcon: SvgPicture.asset("assets/icons/search.svg", color: green),
  //       icon: SvgPicture.asset("assets/icons/searchoutline.svg", color: Get.theme.iconTheme.color),
  //       label: ''),
  //   BottomNavigationBarItem(
  //       activeIcon: SvgPicture.asset("assets/icons/like.svg", color: green, height: 25.h),
  //       icon: SvgPicture.asset("assets/icons/likeoutline.svg", color: Get.theme.iconTheme.color),
  //       label: ''),
  // ];


  @override
  void dispose() {
    searchController.search.clear();
    super.dispose();
  }
}
