import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Constants/constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Controller/songplayer_controller.dart';

RxBool cancel = true.obs;
RxInt progress = 0.obs;

Future<String?> downloadMp3({
  var songUrl,
  String? songtitle,
  String? image,
}) async {
  Directory? externaldir;
  Dio dio = Dio();
  SongPlayerController songPlayerController = Get.put(SongPlayerController());

  CancelToken canceltoken = CancelToken();

  progress.value = 0;
  cancel.value = true;
  try {
    if (!isAndroidVersionUp13) {
      if (await Permission.storage.request().isGranted) {
        externaldir = await getApplicationDocumentsDirectory();

        await dio.download(
          songUrl,
          '${externaldir.path}/$songtitle.mp3',
          cancelToken: canceltoken,
          onReceiveProgress: (rcv, total) {
            progress.value = int.parse(((rcv / total) * 100).toStringAsFixed(0));
            if (cancel.value == false) {
              canceltoken.cancel('song cancel');
              progress.value = 0;
              songPlayerController.isDownload.value = false;
            }
          },
          deleteOnError: true,
        );

        return '${externaldir.path}/$songtitle.mp3';
      } else {
        return null;
      }
    } else {
      externaldir = await getApplicationDocumentsDirectory();

      await dio.download(
        songUrl,
        '${externaldir.path}/$songtitle.mp3',
        cancelToken: canceltoken,
        onReceiveProgress: (rcv, total) {
          progress.value = int.parse(((rcv / total) * 100).toStringAsFixed(0));
          if (cancel.value == false) {
            canceltoken.cancel('song cancel');
            progress.value = 0;
            songPlayerController.isDownload.value = false;
          }
        },
        deleteOnError: true,
      );

      return '${externaldir.path}/$songtitle.mp3';
    }
  } catch (e, trace) {
    if (kDebugMode) {
      print('ERROR ::  $e');
      print('TRACE :: $trace');
    }
    return null;
  }
}
