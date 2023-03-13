// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/audio_constant.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/UI/SongScreen/songscreen.dart';
import 'package:musicplayer/Ads/appAds.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Constants/Custom_widget/cachednetworkimage.dart';
import '../../Constants/Custom_widget/textwidget.dart';
import '../../Controller/viewallscreen_controller.dart';
import '../../httpmodel/genersbyid_model.dart';
import '../../httpmodel/home_model.dart';
import '../Home/albumsongsscreen.dart';
import '../Home/artistsongscreen.dart';
import '../Home/generssongscreen.dart';

class ViewAllScreen extends StatelessWidget {
  final String title;
  final HomeMp3Data? data;
  final GenersModelById? genersModel;

  const ViewAllScreen({Key? key, required this.title, this.data, this.genersModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ViewAllScreenController viewAllScreenController =
    Get.put(ViewAllScreenController(data: data, title: title, genersModel: genersModel));
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextWidget.regular(title, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: Obx(() {
                viewAllScreenController.album.value;
                viewAllScreenController.artist.value;
                viewAllScreenController.trending.value;
                viewAllScreenController.geners.value;
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(waterDropColor: shimmerGreen),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("release to load more");
                      } else {
                        body = const Text("No more Data");
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: viewAllScreenController.refreshController,
                  onRefresh: viewAllScreenController.onRefresh,
                  onLoading: viewAllScreenController.onLoading,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: [
                        AnimationLimiter(
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: viewAllScreenController
                                .contSwitch(title)
                                .value
                            /* viewAllScreenController.data != null
                              ? viewAllScreenController.data!.onlineMp3.latestArtist.length == viewAllScreenController.artist.length
                                  ? viewAllScreenController.artist.length
                                  : viewAllScreenController.data!.onlineMp3.trendingSongs.length == viewAllScreenController.trending.length
                                      ? viewAllScreenController.trending.length
                                      : viewAllScreenController.album.length
                              : viewAllScreenController.geners.value.onlineMp3.length*/,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10.0.r, mainAxisSpacing: 12.0.r, childAspectRatio: 0.9, crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  viewAllScreenController.data != null
                                      ? viewAllScreenController.data!.onlineMp3.latestAlbum.length == viewAllScreenController.album.length
                                      ? {
                                    /// Ads
                                    AdmobAds().showInterstitialAd(),

                                    Get.to(() =>
                                        AlbumSongsScreen(
                                          id: viewAllScreenController.album[index].aid,
                                          albumName: viewAllScreenController.album[index].albumName,
                                        ))
                                  }
                                      : viewAllScreenController.data!.onlineMp3.trendingSongs.length ==
                                      viewAllScreenController.trending.length
                                      ? {
                                    showLoader(context),
                                    songListModel.clear(),
                                    for (int i = 0; i < viewAllScreenController.data!.onlineMp3.trendingSongs.length; i++)
                                      {
                                        songListModel.add(SongListModel(
                                            id: viewAllScreenController.data!.onlineMp3.trendingSongs[i].id,
                                            image: viewAllScreenController.data!.onlineMp3.trendingSongs[i].mp3ThumbnailB,
                                            artist: viewAllScreenController.data!.onlineMp3.trendingSongs[i].mp3Artist,
                                            title: viewAllScreenController.data!.onlineMp3.trendingSongs[i].mp3Title,
                                            url: viewAllScreenController.data!.onlineMp3.trendingSongs[i].mp3Url)),
                                      },
                                    await selectSong(index: index).whenComplete(() => hideLoader(context)),
                                    Get.to(() => SongScreen(id: viewAllScreenController.data!.onlineMp3.trendingSongs[index].id)),
                                  }
                                      : {
                                    /// Ads
                                    AdmobAds().showInterstitialAd(),

                                    Get.to(() =>
                                        ArtistSongsScreen(
                                          artistName: viewAllScreenController.artist[index].artistName,
                                          id: viewAllScreenController.artist[index].id,
                                        ))
                                  }
                                      : {
                                    /// Ads
                                    AdmobAds().showInterstitialAd(),

                                    Get.to(() =>
                                        GenersSongScreen(
                                          id: viewAllScreenController.geners.value.onlineMp3[index].pid,
                                          albumName: viewAllScreenController.geners.value.onlineMp3[index].playlistName,
                                        ))
                                  };
                                },
                                child: AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 400),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: Column(
                                        children: [
                                          ImageView(
                                            imageUrl: viewAllScreenController.data != null
                                                ? viewAllScreenController.data!.onlineMp3.latestArtist.length ==
                                                viewAllScreenController.artist.length
                                                ? viewAllScreenController.artist[index].artistImage
                                                : viewAllScreenController.data!.onlineMp3.trendingSongs.length ==
                                                viewAllScreenController.trending.length
                                                ? viewAllScreenController.trending[index].mp3ThumbnailB
                                                : viewAllScreenController.album[index].albumImage
                                                : viewAllScreenController.geners.value.onlineMp3[index].playlistImage,
                                            height: 162.w,
                                            width: 170.w,
                                            radius: 20.r,
                                          ),
                                          SizedBox(height: 5.w),
                                          TextWidget.regular(
                                              viewAllScreenController.data != null
                                                  ? viewAllScreenController.data!.onlineMp3.latestArtist.length ==
                                                  viewAllScreenController.artist.length
                                                  ? viewAllScreenController.artist[index].artistName
                                                  : viewAllScreenController.data!.onlineMp3.trendingSongs.length ==
                                                  viewAllScreenController.trending.length
                                                  ? viewAllScreenController.trending[index].mp3Title
                                                  : viewAllScreenController.album[index].albumName
                                                  : viewAllScreenController.geners.value.onlineMp3[index].playlistName,
                                              fontSize: 16.sp,
                                              fontFamily: "Poppins-Medium"),
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
                  ),
                );
              }),
            ),
            Positioned(
              bottom: 0.h,
              left: 0.w,
              child: slidablePanelHeader(
                context: context,
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SongScreen(id: assetsAudioPlayer.current.value!.audio.audio.metas.id);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
