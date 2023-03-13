import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'Custom_widget/cachednetworkimage.dart';
import 'Custom_widget/textwidget.dart';
import 'constant.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

RxBool playerVisible = false.obs;
List<Audio> playList = [];
List<SongListModel> songListModel = [];
AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId('0');
RxBool nextSong = true.obs;

class SongListModel {
  SongListModel({
    required this.id,
    required this.image,
    required this.artist,
    required this.title,
    required this.url,
  });

  final String id;
  final String image;
  final String artist;
  final String title;
  final String url;
}

Future<void> selectSong({int? index}) async {
  playList.clear();
  try {
    for (var i = 0; i < songListModel.length; i++) {
      if (songListModel[i].image.contains('http')) {
        playList.add(
          Audio.network(
            songListModel[i].url,
            metas: Metas(
              id: songListModel[i].id.toString(),
              title: songListModel[i].title,
              artist: songListModel[i].artist,
              album: songListModel[i].url,
              image: MetasImage.network(songListModel[i].image),
            ),
          ),
        );
      } else {
        playList.add(
          Audio.file(
            songListModel[i].url,
            metas: Metas(
              id: songListModel[i].id.toString(),
              title: songListModel[i].title,
              artist: songListModel[i].artist,
              album: songListModel[i].url,
              image: MetasImage.file(songListModel[i].image),
            ),
          ),
        );
      }
    }
    final RxBool nextLoader = true.obs;
    final RxBool previousLoader = true.obs;
    await assetsAudioPlayer.open(
      Playlist(audios: playList, startIndex: index ?? 0),
      showNotification: true,
      autoStart: true,
      notificationSettings: NotificationSettings(
        stopEnabled: true,
        nextEnabled: true,
        prevEnabled: true,
        playPauseEnabled: true,
        customStopAction: (value) {
          playList.clear();
          value.stop();
          playerVisible.value = false;
        },
        customPrevAction: (value) {
          if (previousLoader.value) {
            previousLoader.value = false;
            assetsAudioPlayer.previous().whenComplete(() => previousLoader.value = true);
          }
        },
        customNextAction: (value) {
          if (nextLoader.value) {
            nextLoader.value = false;
            assetsAudioPlayer.next().whenComplete(() => nextLoader.value = true);
          }
        },
      ),
    );
    playerVisible.value = true;
    await assetsAudioPlayer.play();
  } catch (e, trace) {
    if (kDebugMode) {
      print(e);
    }
    if (kDebugMode) {
      print(trace);
    }
  }
}

Widget slidablePanelHeader({required BuildContext context, required VoidCallback onTap}) {
  return Obx(() {
    return playerVisible.value
        ? Scrollable(
        viewportBuilder: (BuildContext context, ViewportOffset position) {
            return Slidable(
                /// start action panel
                startActionPane: ActionPane(
                  extentRatio: 0.16,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (val) {
                        playerVisible.value = false;
                        assetsAudioPlayer.stop();
                      },
                      backgroundColor: green,
                      foregroundColor: Get.theme.iconTheme.color,
                      icon: Icons.close,
                    ),
                  ],
                ),

                /// end action panel
                endActionPane: ActionPane(
                  extentRatio: 0.16,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (val) {
                        playerVisible.value = false;
                        assetsAudioPlayer.stop();
                      },
                      backgroundColor: green,
                      foregroundColor: Get.theme.iconTheme.color,
                      icon: Icons.close,
                    ),
                  ],
                ),
                child: assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
                  return PlayerBuilder.current(
                      player: assetsAudioPlayer,
                      builder: (context, value) {
                        return GestureDetector(
                          onTap: onTap,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: Platform.isIOS ? 85.r : 75.r,
                            color: Get.theme.colorScheme.background,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    !value.audio.audio.metas.image!.path.contains('http')
                                        ? Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.r),
                                              child: Image.file(
                                                File(value.audio.audio.metas.image!.path),
                                                fit: BoxFit.cover,
                                                width: 50.w,
                                                height: 60.h,
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ImageView(
                                              imageUrl: value.audio.audio.metas.image!.path,
                                              width: 50.w,
                                              height: 60.h,
                                              radius: 10.r,
                                            ),
                                          ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextWidget.regular(
                                                value.audio.audio.metas.title!,
                                                fontFamily: "Poppins-Bold",
                                                fontSize: 16.sp,
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.bold,
                                                textOverflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 2.h),
                                              SizedBox(
                                                width: 200.w,
                                                child: TextWidget.regular(value.audio.audio.metas.artist!,
                                                    textOverflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    fontSize: 14.sp,
                                                    maxLines: 1,
                                                    fontFamily: "Poppins-Medium",
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          PlayerBuilder.isPlaying(
                                            player: assetsAudioPlayer,
                                            builder: (context, isPlaying) {
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      assetsAudioPlayer.playOrPause();
                                                    },
                                                    child: SvgPicture.asset(isPlaying ? 'assets/icons/pause.svg' : 'assets/icons/play.svg',
                                                        width: 40.r, height: 40.r, color: Get.theme.colorScheme.primary),
                                                  ),
                                                  Obx(() {
                                                    nextSong.value;
                                                    return IconButton(
                                                      disabledColor: Colors.grey,
                                                      color: Get.theme.colorScheme.primary,
                                                      onPressed: nextSong.value
                                                          ? () async {
                                                              nextSong.value = false;
                                                              assetsAudioPlayer.next().whenComplete(() => nextSong.value = true);
                                                            }
                                                          : null,
                                                      icon: Icon(
                                                        Icons.skip_next_rounded,
                                                        size: 25.sp,
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (infos != null)
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: green,
                                      inactiveTrackColor: Get.theme.colorScheme.primary.withOpacity(0.2),
                                      trackHeight: 2.5,
                                      thumbColor: green,
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 0.0,
                                      ),
                                      overlayColor: Colors.transparent,
                                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 2.0),
                                    ),
                                    child: Center(
                                      child: Slider(
                                        min: 0.0,
                                        max: infos.duration.inMilliseconds.toDouble(),
                                        value: infos.currentPosition.inMilliseconds.toDouble(),
                                        onChanged: (double value) {},
                                      ),
                                    ),
                                  ),
                                if (Platform.isIOS)
                                  SizedBox(
                                    height: 15.h,
                                  ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              );
          }
        )
        : const SizedBox.shrink();
  });
}
