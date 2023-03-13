import 'package:get/get.dart';
import 'package:musicplayer/service/httpservice.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../httpmodel/genersbyid_model.dart';
import '../httpmodel/home_model.dart';

class ViewAllScreenController extends GetxController {
  HomeMp3Data? data;
  GenersModelById? genersModel;
  String title;

  ViewAllScreenController({this.data, required this.title, this.genersModel});

  RxList<LatestArtist> artist = <LatestArtist>[].obs;
  RxList<LatestAlbum> album = <LatestAlbum>[].obs;
  RxList<TrendingSong> trending = <TrendingSong>[].obs;
  Rx<GenersModelById> geners = GenersModelById(onlineMp3: []).obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  RxInt pages = 1.obs;

  void onRefresh() async {
    pages.value = 1;
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    pages.value++;
    contPagination(title);
    refreshController.loadComplete();
  }

  @override
  void onInit() {
    // pages.value = 1;
    viewAllSwitch(title);
    // contPagination(title);

    super.onInit();
  }

  RxInt contSwitch(type) {
    RxInt get() {
      switch (type) {
        case 'Latest Album':
          return data!.onlineMp3.latestAlbum.length.obs;
        case 'Latest Artist':
          return data!.onlineMp3.latestArtist.length.obs;
        case 'Trending Songs':
          return data!.onlineMp3.trendingSongs.length.obs;
        default:
          return 0.obs;
      }
    }

    if (data != null) {
      return get();
    } else {
      return genersModel!.onlineMp3.length.obs;
    }
  }

  contPagination(type) {
    get() async {
      switch (type) {
        case 'Latest Album':
          {
            // if (album.length % 10 == 0) {
            //   await HttpService().getLatestAlbum(page: pages.value).then((value) {
            //     for (var i = 0; i < value!.length; i++) {
            //       album.add(value[i]);
            //     }
            //     pages.value++;
            //   });
            //   // allauthorbool.value = true;
            //   // allauthorbool.value = false;
            // }

            if (album.length % 10 == 0) {
              HttpService().getLatestAlbum(page: pages.value).then((val) {
                val!.forEach((element) {
                  album.add(element);
                });
                pages.value++;
                refreshController.loadComplete();
              });
            }
          }
          break;
        case 'Latest Artist':
          {
            if (artist.length % 10 == 0) {
              HttpService().getArtist(page: pages.value).then((val) {
                val!.forEach((element) {
                  artist.add(element);
                });
                pages.value++;
                refreshController.loadComplete();
              });
            }
          }
          break;
        case 'Trending Songs':
          {
            if (trending.length % 10 == 0) {
              HttpService().getTrending(page: pages.value).then((val) {
                val!.forEach((element) {
                  trending.add(element);
                });
                pages.value++;
                refreshController.loadComplete();
              });
            }
          }
          break;
        default:
          {}
          break;
      }
    }

    if (data != null) {
      return get();
    } else {
      return genersModel!.onlineMp3.length.obs;
    }
  }

  viewAllSwitch(type) {
    if (data != null) {
      switch (type) {
        case 'Latest Album':
          album.value = data!.onlineMp3.latestAlbum;
          break;
        case 'Latest Artist':
          artist.value = data!.onlineMp3.latestArtist;
          break;
        case 'Trending Songs':
          trending.value = data!.onlineMp3.trendingSongs;
          break;
        default:
          break;
      }

      // Map map = {
      //   'Latest Album': data!.onlineMp3.latestAlbum,
      //   'Latest Artist': data!.onlineMp3.latestArtist,
      //   'Trending Songs': data!.onlineMp3.trendingSongs
      // };
      // if (type == 'Trending Songs') {
      //   trending.value = map[type];
      // } else {
      //   artist.value = map[type];
      // }
    } else {
      geners.value = genersModel!;
    }
  }
}
