import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:musicplayer/UI/SongScreen/songscreen.dart';
import 'package:musicplayer/service/httpservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_constant.dart';


PendingDynamicLinkData? initialLink;

/// when app kill
initDynamicLinks() async {
  print("Initialial Link =========");

  var deepLink = initialLink!.link;
  print("Initialial Link ::::::: ${deepLink.path}");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (deepLink.path) {
    case "/BlogScreen":
      {

      }
      break;
    case "/Song":
      {
        print("THis is Radio Screen Id : ${initialLink!.link.queryParameters['id'].toString()}");
        await HttpService().getSingleSong(userId: prefs.getString('user_id'),songId: initialLink!.link.queryParameters['id'].toString()).then((value) async {
          songListModel.clear();
          songListModel.add(SongListModel(
            id: value.onlineMp3[0].id,
            image: value.onlineMp3[0].mp3ThumbnailB,
            artist: value.onlineMp3[0].mp3Artist,
            title: value.onlineMp3[0].mp3Title,
            url: value.onlineMp3[0].mp3Url,
          ));

          await selectSong(index: 0);
          Get.to(
                  () => SongScreen(
                fromLink: "True",
                id: value.onlineMp3[0].id,
              ),
              transition: Transition.native,
              duration: const Duration(seconds: 1));
        });
      }
      break;
    case "/Author":
      {

      }
      break;
    default:
      {

      }
  }

}

// liveradio.page.link
/// When App In Background
dynamicLink(){
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Initialial  Link  backGround ${dynamicLinkData.link.path}");
    switch (dynamicLinkData.link.path) {
      case "/MusicPlayer":
        {

        }
        break;
      case "/Song":
        {
          print("THis is Radio Screen Id : ${dynamicLinkData.link.queryParameters['id'].toString()}");
          await HttpService().getSingleSong(userId: prefs.getString('user_id'),songId: dynamicLinkData.link.queryParameters['id'].toString()).then((value) async {
            songListModel.clear();
              songListModel.add(SongListModel(
                id: value.onlineMp3[0].id,
                image: value.onlineMp3[0].mp3ThumbnailB,
                artist: value.onlineMp3[0].mp3Artist,
                title: value.onlineMp3[0].mp3Title,
                url: value.onlineMp3[0].mp3Url,
              ));

            await selectSong(index: 0);
            Get.to(
                    () => SongScreen(
                      fromLink: "True",
                  id: value.onlineMp3[0].id,
                ),
                transition: Transition.native,
                duration: const Duration(seconds: 1));
          });
        }
        break;
      case "/Author":
        {

        }
        break;
      default:
        {

        }
    }
  });
}


const String prefixLink = 'https://vocsy.page.link';


Future<Uri> createDynamicLink({id, required String path}) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: prefixLink,
    link: Uri.parse(id == null ? '$prefixLink$path' : "$prefixLink$path?id=$id"),
    androidParameters: const AndroidParameters(
      packageName: 'com.vocsy.musicpro',
    ),
    iosParameters: const IOSParameters(
      appStoreId: "1582162273",
      bundleId: 'com.vocsy.musicpro',
    ),
  );
  final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters, shortLinkType: ShortDynamicLinkType.short);

  return dynamicLink.shortUrl;
}