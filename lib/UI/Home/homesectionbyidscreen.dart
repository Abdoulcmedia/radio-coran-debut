import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:musicplayer/UI/SongScreen/songscreen.dart';
import 'package:musicplayer/Ads/appAds.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants/Custom_widget/cachednetworkimage.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Constants/audio_constant.dart';
import '../../Constants/constant.dart';
import '../../Controller/user_controller.dart';

import '../../httpmodel/homesectionbyid_model.dart';
import '../../service/httpservice.dart';

class HomeSectionByIdScreen extends StatelessWidget {
  final String? id;
  final String? name;

  HomeSectionByIdScreen({Key? key, this.id, this.name}) : super(key: key);

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextWidget.regular(
            name!,
            fontFamily: "Poppins-Bold",
            fontSize: 20.sp,
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Ads
                    AdmobAds().bannerAds(),
                    FutureBuilder<HomeSectionbyIdModel?>(
                        future: HttpService().getHomeSectionbyid(id: id, userid: userController.userId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.onlineMp3.isNotEmpty) {
                              return AnimationLimiter(
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.onlineMp3.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10.0.r, mainAxisSpacing: 12.0.r, childAspectRatio: 0.9, crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        showLoader(context);

                                        songListModel.clear();
                                        for (int i = 0; i < snapshot.data!.onlineMp3.length; i++) {
                                          songListModel.add(SongListModel(
                                              id: snapshot.data!.onlineMp3[i].id,
                                              image: snapshot.data!.onlineMp3[i].mp3ThumbnailB,
                                              artist: snapshot.data!.onlineMp3[i].mp3Artist,
                                              title: snapshot.data!.onlineMp3[i].mp3Title,
                                              url: snapshot.data!.onlineMp3[i].mp3Url));
                                        }
                                        await selectSong(index: index).whenComplete(() => hideLoader(context));
                                        Get.to(() => SongScreen(
                                              id: snapshot.data!.onlineMp3[index].id,
                                            ),transition: Transition.native,duration: const Duration(seconds:1));
                                      },
                                      child: AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration: const Duration(milliseconds: 500),
                                        columnCount: 2,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: Column(
                                              children: [
                                                ImageView(
                                                  imageUrl: snapshot.data!.onlineMp3[index].mp3ThumbnailB,
                                                  height: 165.h,
                                                  width: 170.w,
                                                  memCacheHeight: 340,
                                                  radius: 15.r,
                                                ),
                                                SizedBox(height: 5.w),
                                                TextWidget.regular(snapshot.data!.onlineMp3[index].mp3Title,
                                                    fontFamily: "Poppins-Medium", fontSize: 16.sp),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(child: TextWidget.regular('nodata'.tr, fontFamily: "Poppins-Medium"));
                            }
                          } else {
                            return Shimmer.fromColors(
                              baseColor: shimmerGreen,
                              highlightColor: shimmerLightGreen,
                              child: GridView.builder(
                                padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: 8,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10.0.r, mainAxisSpacing: 10.0.r, childAspectRatio: 0.9, crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 170.h,
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        height: 15.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.h,
              left: 0.w,
              child: slidablePanelHeader(
                context: context,
                onTap: () {
                  Get.to(SongScreen(id: assetsAudioPlayer.current.value!.audio.audio.metas.id),
                      transition: Transition.native, duration: const Duration(seconds: 1));
                },
              ),
            ),
          ],
        ));
  }
}
