import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:musicplayer/Constants/audio_constant.dart';
import 'package:musicplayer/Constants/dynamic_link.dart';
import 'package:musicplayer/UI/BottomNavigatorBar/bottomnavigatorbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:musicplayer/Constants/Custom_widget/textwidget.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:musicplayer/UI/SeekBar/seekbar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_esys_flutter_share/vocsy_esys_flutter_share.dart';
import '../../Constants/database.dart';
import '../../Constants/downloadmp3.dart';
import '../../Controller/songplayer_controller.dart';
import '../../Controller/user_controller.dart';
import '../../httpmodel/download_model.dart';

class SongScreen extends StatelessWidget {
  final String? id;
  final String? fromLink;

  SongScreen({Key? key, this.id, this.fromLink}) : super(key: key);

  final UserController userController = Get.put(UserController());

  final RxBool nextLoader = true.obs;
  final RxBool previousLoader = true.obs;

  final bool? download = false;
  final RxBool isdownload = false.obs;

  getdownload(id) async {
    isdownload.value = await DatabaseHelper().isdownload(id);
  }

  Future<bool> _willPopCallback() async {
    if (fromLink == "True") {
      Get.offAll(MyBottomNavigationBar());
    } else {
      Get.back();
    }
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    final SongPlayerController songPlayerController = Get.put(SongPlayerController(postid: id!));
    songPlayerController.getfavourite(postid: id);
    return WillPopScope(
      onWillPop: () {
        return _willPopCallback();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextWidget.regular('playerscreen'.tr, fontFamily: "Poppins-Bold", fontSize: 20.sp),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
                return PlayerBuilder.current(
                    player: assetsAudioPlayer,
                    builder: (context, value) {

                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 45.h, bottom: 20.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                ),
                                child: !value.audio.audio.metas.image!.path.contains('http')
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: Image.file(
                                    File(value.audio.audio.metas.image!.path),
                                    fit: BoxFit.cover,
                                    height: 300.h,
                                    width: 300.h,
                                  ),
                                )
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: CachedNetworkImage(
                                    imageUrl: value.audio.audio.metas.image!.path,
                                    height: 300.h,
                                    width: 300.h,
                                    fit: BoxFit.cover,
                                    memCacheHeight: 400,
                                  ),
                                )),
                            SizedBox(height: 20.h),

                            TextWidget.regular(value.audio.audio.metas.title ?? "", fontFamily: "Poppins-Bold", fontSize: 25.sp),

                            SizedBox(height: 25.h),

                            /// all icons
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    isdownload.value;
                                    if (isdownload.value == false) {
                                      return IconButton(
                                        icon: SvgPicture.asset(
                                          'assets/icons/shareicon.svg',
                                          color: Get.theme.colorScheme.primary,
                                          height: 20.h,
                                        ),

                                        onPressed: () async {
                                          songPlayerController.isShare.value = true;
                                          Uri? link = await createDynamicLink(path: "/Song", id: value.audio.audio.metas.id);
                                          try {
                                            var request = await HttpClient().getUrl(Uri.parse(value.audio.audio.metas.image!.path));
                                            var response = await request.close();
                                            Uint8List bytes = await consolidateHttpClientResponseBytes(response);
                                            songPlayerController.isShare.value = false;
                                            await VocsyShare.files(
                                                'Music Player',
                                                {
                                                  '${value.audio.audio.metas.title}.png': bytes,
                                                },
                                                '*/*',
                                                text: 'Song name : ${value.audio.audio.metas.title}\n'
                                                    'Song artist : ${value.audio.audio.metas.artist}\n'
                                                    'MusicPlayer : ${link}');
                                          } catch (e) {
                                            if (kDebugMode) {
                                              print('error: $e');
                                            }
                                          }
                                        },
                                      );
                                    } else {
                                      return InkWell(
                                        onTap: () {
                                          final snackBar = SnackBar(
                                            content: Row(
                                              children: [
                                                const Icon(Icons.error_outline),
                                                SizedBox(width: 10.w),
                                                TextWidget.regular('downloadedsongnotshare'.tr,
                                                    fontFamily: "Poppins-Medium",
                                                    color: Get.theme.colorScheme.primary,
                                                    fontSize: 15.sp,
                                                    textAlign: TextAlign.start),
                                              ],
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            duration: const Duration(seconds: 2),
                                            margin: const EdgeInsets.all(12.0),
                                            dismissDirection: DismissDirection.startToEnd,
                                            backgroundColor: shimmerGreen,
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/dontshareicon.svg',
                                          color: Get.theme.colorScheme.primary,
                                          height: 20.h,
                                        ),
                                      );
                                    }
                                  }),

                                  /// Favourite

                                  // FavouriteButtonWidget(postid: value.audio.audio.metas.id),

                                  if(!userController.isguest.value) Obx(() {
                                    songPlayerController.isLike.value;
                                    return IconButton(
                                      splashRadius: 1.0,
                                      onPressed: () async {
                                        await songPlayerController
                                            .favouriteBookController(postid: id, userid: userController.userId)
                                            .then((val) async {
                                          val.onlineMp3[0].success == "1"
                                              ? songPlayerController.isLike.value = true
                                              : songPlayerController.isLike.value = false;
                                          await songPlayerController.getfavouriteBookController(userid: userController.userId);
                                        }).whenComplete(() => songPlayerController.update());
                                      },
                                      icon: songPlayerController.isLike.value == true
                                          ? SvgPicture.asset(
                                        "assets/icons/like.svg",
                                        color: Get.theme.colorScheme.primaryContainer,
                                        height: 25.h,
                                      )
                                          : SvgPicture.asset("assets/icons/likeoutline.svg", color: Get.theme.colorScheme.primary),
                                    );
                                  }),

                                  /// Favourite

                                  /// Download

                                  Obx(() {
                                    isdownload.value;
                                    songPlayerController.isDownload.value;
                                    songPlayerController.downloadingBookId.value;

                                    getdownload(value.audio.audio.metas.id);

                                    return download == true
                                        ? const Icon(Icons.download_done)
                                        : GestureDetector(
                                      onTap: () async {
                                        if (cancel.value && isdownload.value == false && songPlayerController.isDownload.value == false) {
                                          String audiourl = value.audio.audio.metas.album!;
                                          String? audioid = value.audio.audio.metas.id;
                                          String? songtitle = value.audio.audio.metas.title;
                                          String? artist = value.audio.audio.metas.artist;
                                          String imageUrl = value.audio.audio.metas.image!.path;
                                          // var status = await Permission.storage.request();
                                          var simage = await http.get(Uri.parse(imageUrl));

                                          File? file;
                                          if (!isAndroidVersionUp13) {
                                            if (await Permission.storage
                                                .request()
                                                .isGranted) {
                                              songPlayerController.isDownload.value = true;
                                              songPlayerController.downloadingBookId.value = assetsAudioPlayer.current.value!.audio.audio.metas.id!;
                                              Directory appDocDir = Platform.isAndroid
                                                  ? await getApplicationDocumentsDirectory()
                                                  : await getApplicationDocumentsDirectory();
                                              if (Platform.isAndroid) {
                                                Directory('${appDocDir.path}/Mp3').create();
                                              }
                                              file = File(Platform.isIOS
                                                  ? '${appDocDir.path}/$songtitle.png'
                                                  : '${appDocDir.path}/Mp3/$songtitle.png');
                                              file.writeAsBytesSync(simage.bodyBytes);
                                            }
                                          } else {
                                            songPlayerController.isDownload.value = true;
                                            songPlayerController.downloadingBookId.value = assetsAudioPlayer.current.value!.audio.audio.metas.id!;
                                            Directory appDocDir = Platform.isAndroid
                                                ? await getApplicationDocumentsDirectory()
                                                : await getApplicationDocumentsDirectory();
                                            if (Platform.isAndroid) {
                                              Directory('${appDocDir.path}/Mp3').create();
                                            }
                                            file = File(Platform.isIOS
                                                ? '${appDocDir.path}/$songtitle.png'
                                                : '${appDocDir.path}/Mp3/$songtitle.png');
                                            file.writeAsBytesSync(simage.bodyBytes);
                                          }
                                          try {
                                            await downloadMp3(songUrl: audiourl, songtitle: songtitle, image: imageUrl).then((val) {
                                              if (val != null) {
                                                isdownload.value = true;
                                                DatabaseHelper()
                                                    .addDownload(DownloadSong(
                                                    id: int.parse(audioid!),
                                                    link: val,
                                                    title: songtitle,
                                                    artist: artist,
                                                    imagepath: file!.path,
                                                    userId: userController.userId,
                                                    songid: int.parse(value.audio.audio.metas.id!)))
                                                    .whenComplete(() {
                                                  songPlayerController.isDownload.value = false;
                                                  songPlayerController.downloadingBookId.value = "";
                                                });
                                              }
                                            });
                                          } catch (e) {
                                            if (kDebugMode) {
                                              print('ERROR IN DOWNLOAD $e');
                                            }
                                          }
                                        }
                                        else {
                                          snackbar(message: "", title: "downloadprogress".tr);
                                        }
                                        // cancel.value = true;
                                      },
                                      child: songPlayerController.isDownload.value == true &&
                                          songPlayerController.downloadingBookId.value == assetsAudioPlayer.current.value!.audio.audio.metas.id!
                                          ? SizedBox(
                                        width: 25.w,
                                        child: InkWell(
                                          onTap: () async {
                                            cancel.value = false;
                                          },
                                          child: CircularPercentIndicator(
                                            radius: 14.r,
                                            lineWidth: 3.0,
                                            percent: progress.value / 100,
                                            backgroundColor: Colors.transparent,
                                            center: TextWidget.regular(
                                              "${(progress.value)}%",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                              fontFamily: "Poppins-Medium",
                                            ),
                                            circularStrokeCap: CircularStrokeCap.round,
                                            progressColor: shimmerGreen,
                                          ),
                                        ),
                                      )
                                          : Center(
                                        child: isdownload.value == false
                                            ? SizedBox(
                                          width: 25.w,
                                          child: SvgPicture.asset(
                                            'assets/icons/download.svg',
                                            color: Get.theme.colorScheme.primary,
                                          ),
                                        )
                                            : const Icon(Icons.download_done),
                                      ),
                                    );
                                  }),

                                  /// Download
                                ],
                              ),
                            ),

                            SizedBox(height: 15.h),

                            assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
                              if (assetsAudioPlayer.playlist!.audios.last.metas.id == assetsAudioPlayer.current.value!.audio.audio.metas.id &&
                                  infos!.currentPosition.inSeconds == infos.duration.inSeconds - 1) {
                                assetsAudioPlayer.stop();
                                Get.back();
                                return const SizedBox.shrink();
                              } else {
                                if (infos!.duration > const Duration(seconds: 0)) {
                                  return PositionSeekWidget(
                                      currentPosition: infos.currentPosition,
                                      duration: infos.duration,
                                      seekTo: (to) {
                                        if (assetsAudioPlayer.playlist!.audios.last.metas.id ==
                                            assetsAudioPlayer.current.value!.audio.audio.metas.id) {
                                          if (to.inSeconds <= infos.duration.inSeconds - 2) {
                                            assetsAudioPlayer.seek(to);
                                          } else {
                                            assetsAudioPlayer.seek(Duration(seconds: infos.duration.inSeconds - 2));
                                          }
                                        } else {
                                          assetsAudioPlayer.seek(to);
                                        }
                                      });
                                } else {
                                  return PositionSeekWidget(
                                    currentPosition: const Duration(minutes: 0, seconds: 0),
                                    duration: const Duration(minutes: 0, seconds: 0),
                                    seekTo: (to) {
                                      assetsAudioPlayer.seek(to);
                                    },
                                  );
                                }
                              }
                            }),
                            SizedBox(
                              height: 20.h,
                            ),
                            assetsAudioPlayer.builderIsPlaying(
                              builder: (context, isPlaying) {
                                return PlayerBuilder.isPlaying(
                                  player: assetsAudioPlayer,
                                  builder: (context, isPlaying) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Obx(() {
                                            previousLoader.value;
                                            return IconButton(
                                              disabledColor: Colors.grey,
                                              color: Get.theme.colorScheme.primary,
                                              onPressed: assetsAudioPlayer.playlist!.audios.first.metas.id !=
                                                  assetsAudioPlayer.current.value!.audio.audio.metas.id
                                                  ? previousLoader.value
                                                  ? () async {
                                                previousLoader.value = false;
                                                assetsAudioPlayer.previous().whenComplete(() => previousLoader.value = true);
                                              }
                                                  : null
                                                  : null,
                                              icon: const Icon(
                                                Icons.skip_previous_rounded,
                                              ),
                                            );
                                          }),
                                          GestureDetector(
                                              onTap: () {
                                                assetsAudioPlayer.seekBy(const Duration(seconds: -30));
                                              },
                                              child: SvgPicture.asset(
                                                'assets/icons/left30.svg',
                                                width: 30.r,
                                                height: 30.r,
                                                color: Get.theme.colorScheme.primary,
                                              )),
                                          GestureDetector(
                                            onTap: () {
                                              assetsAudioPlayer.playOrPause();
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: green,
                                              radius: 30.r,
                                              child: SvgPicture.asset(isPlaying ? 'assets/icons/pause.svg' : 'assets/icons/play.svg',
                                                  width: 40.r, height: 40.r, color: Colors.white),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                if (assetsAudioPlayer.playlist!.audios.last.metas.id ==
                                                    assetsAudioPlayer.current.value!.audio.audio.metas.id) {
                                                  if (infos!.currentPosition.inSeconds <= infos.duration.inSeconds - 32) {
                                                    assetsAudioPlayer.seekBy(const Duration(seconds: 30));
                                                  } else {
                                                    assetsAudioPlayer.seekBy(
                                                        Duration(seconds: infos.duration.inSeconds - infos.currentPosition.inSeconds - 2));
                                                  }
                                                } else {
                                                  assetsAudioPlayer.seekBy(const Duration(seconds: 30));
                                                }
                                              },
                                              child: SvgPicture.asset('assets/icons/right30.svg',
                                                  width: 35.r, height: 35.r, color: Get.theme.colorScheme.primary)),
                                          Obx(() {
                                            nextLoader.value;
                                            return IconButton(
                                              disabledColor: Colors.grey,
                                              color: Get.theme.colorScheme.primary,
                                              onPressed: assetsAudioPlayer.playlist!.audios.last.metas.id !=
                                                  assetsAudioPlayer.current.value!.audio.audio.metas.id
                                                  ? nextLoader.value
                                                  ? () {
                                                nextLoader.value = false;
                                                assetsAudioPlayer.next().whenComplete(() => nextLoader.value = true);
                                              }
                                                  : null
                                                  : null,
                                              icon: const Icon(
                                                Icons.skip_next_rounded,
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    });
              }),
            ),
            Obx(() {
              if (songPlayerController.isShare.value) {
                return Container(
                  color: Colors.black26,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(color: Colors.green),
                              );
              }  else {
                return SizedBox.shrink();
              }
            })
          ],
        ),
      ),
    );
  }
}
