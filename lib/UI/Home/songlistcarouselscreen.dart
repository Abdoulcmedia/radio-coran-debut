import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/Ads/appAds.dart';
import '../../Constants/Custom_widget/cachednetworkimage.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Constants/audio_constant.dart';
import '../../Controller/user_controller.dart';
import '../../httpmodel/home_model.dart';
import '../SongScreen/songscreen.dart';

class SongListCarouselScreen extends StatelessWidget {
  final String id;
  final String bannerTitle;
  final List<TrendingSong> songlist;

  SongListCarouselScreen({Key? key, required this.id, required this.songlist, required this.bannerTitle}) : super(key: key);
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextWidget.regular(bannerTitle, fontWeight: FontWeight.bold, fontSize: 25.sp, fontFamily: "Poppins-Bold"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: songlist.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          /// Ads
                          AdmobAds().bannerAds(),
                          AnimationLimiter(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: songlist.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10.0.r, mainAxisSpacing: 12.0.r, childAspectRatio: 0.9, crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    showLoader(context);
                                    songListModel.clear();
                                    for (int i = 0; i < songlist.length; i++) {
                                      songListModel.add(SongListModel(
                                          id: songlist[i].id,
                                          image: songlist[i].mp3ThumbnailB,
                                          artist: songlist[i].mp3Artist,
                                          title: songlist[i].mp3Title,
                                          url: songlist[i].mp3Url));
                                    }
                                    await selectSong(index: index).whenComplete(() => hideLoader(context));
                                    Get.to(
                                        () => SongScreen(
                                              id: songlist[index].id,
                                            ),
                                        transition: Transition.native,
                                        duration: const Duration(seconds: 1));
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
                                              imageUrl: songlist[index].mp3ThumbnailB,
                                              height: 165.h,
                                              width: 170.w,
                                              radius: 15.r,
                                            ),
                                            SizedBox(height: 5.w,),
                                            TextWidget.regular(songlist[index].mp3Title, fontSize: 16.sp, fontFamily: "Poppins-Medium"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: TextWidget.regular('nosong'.tr, fontSize: 14.sp, fontFamily: "Poppins-Bold"),
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
