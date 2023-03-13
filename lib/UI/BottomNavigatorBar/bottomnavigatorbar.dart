import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/audio_constant.dart';
import 'package:musicplayer/Constants/constant.dart';
import '../../Controller/bottomnavigator_controller.dart';
import '../../Controller/user_controller.dart';
import '../SongScreen/songscreen.dart';

class MyBottomNavigationBar extends GetView {
  MyBottomNavigationBar({Key? key}) : super(key: key);

  final bottomNavigationController = Get.put(BottomNavigationController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xff234F68),
          unselectedItemColor: Colors.grey,
          onTap: (indx) {
            bottomNavigationController.selectedIndex.value = indx;
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset("assets/icons/home.svg", color: green),
                icon: SvgPicture.asset("assets/icons/homeoutline.svg", color: Theme.of(context).iconTheme.color),
                label: ''),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset("assets/icons/search.svg", color: green),
                icon: SvgPicture.asset("assets/icons/searchoutline.svg", color: Theme.of(context).iconTheme.color),
                label: ''),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset("assets/icons/like.svg", color: green, height: 25.h),
                icon: SvgPicture.asset("assets/icons/likeoutline.svg", color: Theme.of(context).iconTheme.color),
                label: ''),
          ],
          currentIndex: bottomNavigationController.selectedIndex.value,
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: IndexedStack(index: bottomNavigationController.selectedIndex.value, children: bottomNavigationController.tabPage)),
              slidablePanelHeader(
                context: context,
                onTap: () async {
                  Get.to(SongScreen(id: assetsAudioPlayer.current.value!.audio.audio.metas.id),
                      transition: Transition.native, duration: const Duration(seconds: 1));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
