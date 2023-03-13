import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/Custom_widget/cachednetworkimage.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/UI/AllScreen/viewallscreen.dart';
import 'package:musicplayer/UI/AppDrawerScreen/drawerscreen.dart';
import 'package:musicplayer/Ads/appAds.dart';
import 'package:musicplayer/httpmodel/home_model.dart';
import 'package:musicplayer/service/httpservice.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants/audio_constant.dart';
import '../../httpmodel/geners_list_model.dart';
import '../../httpmodel/genersbyid_model.dart';
import '../../httpmodel/homesection_model.dart';
import '../Home/albumsongsscreen.dart';
import '../Home/artistsongscreen.dart';
import '../Home/generssongscreen.dart';
import '../Home/homesectionbyidscreen.dart';
import '../Home/songlistcarouselscreen.dart';
import '../SongScreen/songscreen.dart';

class HomeScreen extends GetView {
  HomeScreen({Key? key}) : super(key: key);

  final List<Color> colors = <Color>[green800, green600, green400, green300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.regular('home'.tr, fontWeight: FontWeight.bold, fontSize: 25.sp, fontFamily: "Poppins-Bold"),
        centerTitle: true,
      ),
      drawerEnableOpenDragGesture: true,
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: FutureBuilder<HomeMp3Data>(
            future: HttpService().getHome(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<HomeBanner> home = snapshot.data!.onlineMp3.homeBanner;
                final List<LatestAlbum> album = snapshot.data!.onlineMp3.latestAlbum;
                final List<LatestArtist> artist = snapshot.data!.onlineMp3.latestArtist;
                final List<TrendingSong> trending = snapshot.data!.onlineMp3.trendingSongs;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// Home
                    CarouselSlider.builder(
                      itemCount: home.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.easeOut,
                        viewportFraction: 0.8,
                        aspectRatio: 16 / 10,
                      ),
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              /// Ads
                              AdmobAds().showInterstitialAd();

                              Get.to(() => SongListCarouselScreen(
                                    id: home[index].bid,
                                    songlist: home[index].songsList,
                                    bannerTitle: home[index].bannerTitle,
                                  ));
                            },
                            child: ImageView(
                              imageUrl: home[index].bannerImage,
                              height: 150.h,
                              memCacheHeight: 350,
                              radius: 10.r,
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 10.h),

                    ///Home Section
                    FutureBuilder<HomeSectionModel>(
                        future: HttpService().getHomeSection(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              height: 50.h,
                              child: ListView.separated(
                                itemCount: snapshot.data!.onlineMp3.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      /// Ads
                                      AdmobAds().showInterstitialAd();

                                      Get.to(HomeSectionByIdScreen(
                                        id: snapshot.data!.onlineMp3[index].id,
                                        name: snapshot.data!.onlineMp3[index].sectionTitle,
                                      ));
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        color: colors[index],
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Center(
                                        child: TextWidget.regular(snapshot.data!.onlineMp3[index].sectionTitle.toString(),
                                            fontFamily: "Poppins-Medium",
                                            fontSize: 15.sp,
                                            textOverflow: TextOverflow.ellipsis,
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(width: 15.w);
                                },
                              ),
                            );
                          } else {
                            return Shimmer.fromColors(
                              baseColor: shimmerGreen,
                              highlightColor: shimmerLightGreen,
                              child: SizedBox(
                                height: 50.h,
                                child: ListView.separated(
                                  itemCount: 4,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 50.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(width: 15.w);
                                  },
                                ),
                              ),
                            );
                          }
                        }),

                    /// Album
                    Column(
                      children: [
                        SeeAllButton(
                            title: 'latestalbum'.tr,
                            onPressed: () {
                              /// Ads
                              AdmobAds().showInterstitialAd();

                              Get.to(() => ViewAllScreen(title: 'Latest Album', data: snapshot.data!));
                            }),
                        SizedBox(
                          height: 150.w,
                          child: ListView.separated(
                            itemCount: album.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  /// Ads
                                  AdmobAds().showInterstitialAd();

                                  Get.to(AlbumSongsScreen(
                                    id: album[index].aid,
                                    albumName: album[index].albumName,
                                  ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      imageUrl: album[index].albumImage,
                                      height: 120.w,
                                      width: 120.w,
                                      radius: 10.r,
                                    ),
                                    SizedBox(height: 5.w,),
                                    TextWidget.regular(album[index].albumName,
                                        fontFamily: "Poppins-Medium",
                                        fontSize: 15.sp,
                                        textOverflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(width: 15.w);
                            },
                          ),
                        ),
                      ],
                    ),

                    /// Ads
                    AdmobAds().bannerAds(),

                    /// Artist
                    Column(
                      children: [
                        SeeAllButton(
                            title: 'latestartist'.tr,
                            onPressed: () {
                              /// Ads
                              AdmobAds().showInterstitialAd();

                              Get.to(ViewAllScreen(
                                title: 'Latest Artist',
                                data: snapshot.data!,
                              ));
                            }),
                        SizedBox(
                          height: 150.w,
                          width: double.infinity,
                          child: ListView.separated(
                            itemCount: artist.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  /// Ads
                                  AdmobAds().showInterstitialAd();

                                  Get.to(ArtistSongsScreen(artistName: artist[index].artistName));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageView(imageUrl: artist[index].artistImage, height: 120.w, width: 120.w, radius: 10.r),
                                    SizedBox(height: 5.w,),
                                    SizedBox(
                                      width: 100.w,
                                      child: TextWidget.regular(artist[index].artistName,
                                          fontFamily: "Poppins-Medium",
                                          fontSize: 15.sp,
                                          textOverflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(width: 15.w);
                            },
                          ),
                        ),
                      ],
                    ),

                    /// Trending

                    Column(
                      children: [
                        SeeAllButton(
                            title: 'trendingsongs'.tr,
                            onPressed: () {
                              /// Ads
                              AdmobAds().showInterstitialAd();

                              Get.to(() => ViewAllScreen(
                                    title: 'Trending Songs',
                                    data: snapshot.data!,
                                  ));
                            }),
                        SizedBox(
                          height: 150.w,
                          width: double.infinity,
                          child: ListView.separated(
                            itemCount: trending.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  showLoader(context);

                                  songListModel.clear();
                                  for (int i = 0; i < trending.length; i++) {
                                    songListModel.add(SongListModel(
                                      id: trending[i].id,
                                      image: trending[i].mp3ThumbnailB,
                                      artist: trending[i].mp3Artist,
                                      title: trending[i].mp3Title,
                                      url: trending[i].mp3Url,
                                    ));
                                  }
                                  await selectSong(index: index).whenComplete(() => hideLoader(context));
                                  Get.to(
                                      () => SongScreen(
                                            id: trending[index].id,
                                          ),
                                      transition: Transition.native,
                                      duration: const Duration(seconds: 1));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ImageView(imageUrl: trending[index].mp3ThumbnailB, height: 120.w, width: 120.w, radius: 10.r),
                                    SizedBox(height: 5.w,),
                                    SizedBox(
                                      width: 100.w,
                                      child: TextWidget.regular(trending[index].mp3Title,
                                          fontFamily: "Poppins-Medium", fontSize: 15.sp, textOverflow: TextOverflow.ellipsis, maxLines: 1),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(width: 15.w);
                            },
                          ),
                        ),
                      ],
                    ),

                    /// Ads
                    AdmobAds().bannerAds(),

                    /// Geners List
                    FutureBuilder<GenersModel>(
                        future: HttpService().getGeners(),
                        builder: (context, snapshot1) {
                          if (snapshot1.hasData) {
                            return ListView.separated(
                              itemCount: snapshot1.data!.onlineMp3.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index1) {
                                return FutureBuilder<GenersModelById>(
                                    future: HttpService().getGenersById(i: int.parse(snapshot1.data!.onlineMp3[index1].id)),
                                    builder: (context, snapshot2) {
                                      if (snapshot2.hasData) {
                                        return Column(
                                          children: [
                                            SeeAllButton(
                                                title: snapshot1.data!.onlineMp3[index1].genersName,
                                                onPressed: () {
                                                  /// Ads
                                                  AdmobAds().showInterstitialAd();

                                                  Get.to(() => ViewAllScreen(
                                                      title: snapshot1.data!.onlineMp3[index1].genersName, genersModel: snapshot2.data!));
                                                }),
                                            SizedBox(
                                              height: 150.w,
                                              child: ListView.separated(
                                                  separatorBuilder: (BuildContext context, int index) {
                                                    return SizedBox(width: 15.w);
                                                  },
                                                  physics: const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot2.data!.onlineMp3.length,
                                                  scrollDirection: Axis.horizontal,
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        /// Ads
                                                        AdmobAds().showInterstitialAd();

                                                        Get.to(GenersSongScreen(
                                                          id: snapshot2.data!.onlineMp3[index].pid,
                                                          albumName: snapshot2.data!.onlineMp3[index].playlistName,
                                                        ));
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          ImageView(
                                                              imageUrl: snapshot2.data!.onlineMp3[index].playlistImage,
                                                              height: 120.w,
                                                              width: 120.w,
                                                              // memCacheHeight: 240,
                                                              radius: 10.r),
                                                          SizedBox(height: 5.w,),
                                                          TextWidget.regular(snapshot2.data!.onlineMp3[index].playlistName,
                                                              fontFamily: "Poppins-Medium",
                                                              fontSize: 15.sp,
                                                              textOverflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              textAlign: TextAlign.center),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    });
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(width: 15.w);
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                  ],
                );
              } else {
                return Shimmer.fromColors(
                  baseColor: shimmerGreen,
                  highlightColor: shimmerLightGreen,
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: 5,
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayCurve: Curves.easeOut,
                          viewportFraction: 0.8,
                          aspectRatio: 16 / 10,
                        ),
                        itemBuilder: (BuildContext context, int index, int realIndex) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 150.h,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                              ));
                        },
                      ),
                      SizedBox(height: 10.h),
                      SizedBox(
                        height: 50.h,
                        child: ListView.separated(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 15.w);
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ListView.separated(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index1) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 120.w,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                    ),
                                    Container(
                                      height: 20.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: 170,
                                child: ListView.separated(
                                    separatorBuilder: (BuildContext context, int index) {
                                      return SizedBox(width: 15.w);
                                    },
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 120.w,
                                            width: 120.w,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                          ),
                                          SizedBox(height: 8.h),
                                          Container(
                                            height: 15.w,
                                            width: 80.w,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 15.w);
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
