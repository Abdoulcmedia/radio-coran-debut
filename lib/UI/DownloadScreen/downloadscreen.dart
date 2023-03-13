import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/Controller/user_controller.dart';
import 'package:musicplayer/UI/SongScreen/songscreen.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Constants/audio_constant.dart';
import '../../Constants/database.dart';
import '../../Controller/songplayer_controller.dart';
import '../../generated/l10n.dart';
import '../../httpmodel/download_model.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController());
  final SongPlayerController songPlayerController = Get.put(SongPlayerController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextWidget.regular('download'.tr, fontSize: 20.sp, fontWeight: FontWeight.bold, fontFamily: "Poppins-Bold"),
        ),
        body: Obx(() {
          songPlayerController.isdelete.value;
          return Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child: FutureBuilder<List<DownloadSong>>(
                    future: DatabaseHelper().getDownloadSongs(userId: userController.userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return AnimationLimiter(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    showLoader(context);
                                    songListModel.clear();
                                    for (int i = 0; i < snapshot.data!.length; i++) {
                                      songListModel.add(SongListModel(
                                          id: snapshot.data![i].id.toString(),
                                          image: snapshot.data![i].imagepath!,
                                          artist: snapshot.data![i].artist!,
                                          title: snapshot.data![i].title!,
                                          url: snapshot.data![i].link!));
                                    }
                                    await selectSong(index: index).whenComplete(() => hideLoader(context));
                                    Get.to(() => SongScreen(id: snapshot.data![index].id.toString()),
                                        transition: Transition.native, duration: const Duration(seconds: 1));
                                  },
                                  child: AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 300),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Get.theme.colorScheme.onPrimaryContainer,
                                              borderRadius: BorderRadius.circular(10.r),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 70.h,
                                                  width: 70.w,
                                                  margin: EdgeInsets.all(3.r),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.r),
                                                      image: DecorationImage(
                                                          image: FileImage(File(snapshot.data![index].imagepath!)), fit: BoxFit.cover)),
                                                ),
                                                SizedBox(width: 15.w),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          TextWidget.regular(snapshot.data![index].title!,
                                                              fontFamily: "Poppins-Bold",
                                                              fontSize: 16.sp,
                                                              textAlign: TextAlign.start),
                                                          SizedBox(
                                                              width: 200.w,
                                                              child: TextWidget.regular(snapshot.data![index].artist!,
                                                                  fontFamily: "Poppins-Regular",
                                                                  textAlign: TextAlign.start,
                                                                  fontSize: 14.sp,
                                                                  textOverflow: TextOverflow.ellipsis)),
                                                        ],
                                                      ),
                                                      GestureDetector(
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
                                                                    TextWidget.regular('areyousuredelete'.tr,
                                                                        fontFamily: "Poppins-Medium", fontSize: 20.sp),
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
                                                                              width: 75.w,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.grey,
                                                                                borderRadius: BorderRadius.circular(10.r),
                                                                              ),
                                                                              child: Center(
                                                                                child: TextWidget.regular('cancel'.tr,
                                                                                    fontFamily: "Poppins-Medium",
                                                                                    fontSize: 15.sp,
                                                                                    color: Colors.white),
                                                                              ),
                                                                            )),
                                                                        SizedBox(
                                                                          width: 10.w,
                                                                        ),
                                                                        InkWell(
                                                                          onTap: () async {
                                                                            songPlayerController.isdelete.value = true;
                                                                            songPlayerController.isdelete.value = false;
                                                                            await DatabaseHelper()
                                                                                .deleteDownloadSongs(snapshot.data![index].id!);
                                                                            Get.back();
                                                                          },
                                                                          child: Container(
                                                                            height: 40.h,
                                                                            width: 75.w,
                                                                            decoration: BoxDecoration(
                                                                              color: Get.theme.colorScheme.onPrimary,
                                                                              borderRadius: BorderRadius.circular(10.r),
                                                                            ),
                                                                            child: Center(
                                                                              child: TextWidget.regular('delete'.tr,
                                                                                  fontFamily: "Poppins-Medium",
                                                                                  fontSize: 15.sp,
                                                                                  color: Colors.white),
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
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 25.sp,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: TextWidget.regular('nosongdownloaded'.tr, fontSize: 20.sp, fontFamily: "Poppins-Medium"),
                          );
                        }
                      } else {
                        return Shimmer.fromColors(
                          baseColor: shimmerGreen,
                          highlightColor: shimmerLightGreen,
                          child: ListView.builder(
                            itemCount: 9,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 6.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 70.h,
                                            width: 348.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10.r),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
              ),
              Positioned(
                bottom: 0.h,
                left: 0.w,
                child: slidablePanelHeader(
                  context: context,
                  onTap: () async {
                    Get.to(SongScreen(id: assetsAudioPlayer.current.value!.audio.audio.metas.id),
                        transition: Transition.native, duration: const Duration(seconds: 1));
                  },
                ),
              ),
            ],
          );
        }));
  }
}
