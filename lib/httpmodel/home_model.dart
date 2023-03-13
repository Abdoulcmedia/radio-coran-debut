import 'dart:convert';

HomeMp3Data homeMp3DataFromJson(String str) => HomeMp3Data.fromJson(json.decode(str));

String homeMp3DataToJson(HomeMp3Data data) => json.encode(data.toJson());

class HomeMp3Data {
  HomeMp3Data({
    required this.onlineMp3,
  });

  final OnlineMp3 onlineMp3;

  factory HomeMp3Data.fromJson(Map<String, dynamic> json) => HomeMp3Data(
        onlineMp3: OnlineMp3.fromJson(json["ONLINE_MP3"]),
      );

  Map<String, dynamic> toJson() => {
        "ONLINE_MP3": onlineMp3.toJson(),
      };
}

class OnlineMp3 {
  OnlineMp3({
    required this.homeBanner,
    required this.latestAlbum,
    required this.latestArtist,
    required this.trendingSongs,
  });

  final List<HomeBanner> homeBanner;
  final List<LatestAlbum> latestAlbum;
  final List<LatestArtist> latestArtist;
  final List<TrendingSong> trendingSongs;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
        homeBanner: List<HomeBanner>.from(json["home_banner"].map((x) => HomeBanner.fromJson(x))),
        latestAlbum: List<LatestAlbum>.from(json["latest_album"].map((x) => LatestAlbum.fromJson(x))),
        latestArtist: List<LatestArtist>.from(json["latest_artist"].map((x) => LatestArtist.fromJson(x))),
        trendingSongs: List<TrendingSong>.from(json["trending_songs"].map((x) => TrendingSong.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home_banner": List<dynamic>.from(homeBanner.map((x) => x.toJson())),
        "latest_album": List<dynamic>.from(latestAlbum.map((x) => x.toJson())),
        "latest_artist": List<dynamic>.from(latestArtist.map((x) => x.toJson())),
        "trending_songs": List<dynamic>.from(trendingSongs.map((x) => x.toJson())),
      };
}

class HomeBanner {
  HomeBanner({
    required this.bid,
    required this.bannerTitle,
    required this.bannerSortInfo,
    required this.bannerImage,
    required this.bannerImageThumb,
    required this.songsList,
    required this.totalSongs,
  });

  final String bid;
  final String bannerTitle;
  final String bannerSortInfo;
  final String bannerImage;
  final String bannerImageThumb;
  final List<TrendingSong> songsList;
  final int totalSongs;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => HomeBanner(
        bid: json["bid"],
        bannerTitle: json["banner_title"],
        bannerSortInfo: json["banner_sort_info"],
        bannerImage: json["banner_image"],
        bannerImageThumb: json["banner_image_thumb"],
        songsList: List<TrendingSong>.from(json["songs_list"].map((x) => TrendingSong.fromJson(x))),
        totalSongs: json["total_songs"],
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "banner_title": bannerTitle,
        "banner_sort_info": bannerSortInfo,
        "banner_image": bannerImage,
        "banner_image_thumb": bannerImageThumb,
        "songs_list": List<dynamic>.from(songsList.map((x) => x.toJson())),
        "total_songs": totalSongs,
      };
}

class TrendingSong {
  TrendingSong({
    required this.id,
    required this.catId,
    required this.mp3Type,
    required this.mp3Title,
    required this.mp3Url,
    required this.mp3ThumbnailB,
    required this.mp3ThumbnailS,
    required this.mp3Duration,
    required this.mp3Artist,
    required this.mp3Description,
    required this.totalRate,
    required this.rateAvg,
    required this.totalViews,
    required this.totalDownload,
    required this.cid,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryImageThumb,
  });

  final String id;
  final String catId;
  final Mp3Type? mp3Type;
  final String mp3Title;
  final String mp3Url;
  final String mp3ThumbnailB;
  final String mp3ThumbnailS;
  final String mp3Duration;
  final String mp3Artist;
  final String mp3Description;
  final String totalRate;
  final String rateAvg;
  final String totalViews;
  final String totalDownload;
  final String cid;
  final String categoryName;
  final String categoryImage;
  final String categoryImageThumb;

  factory TrendingSong.fromJson(Map<String, dynamic> json) => TrendingSong(
        id: json["id"],
        catId: json["cat_id"],
        mp3Type: mp3TypeValues.map[json["mp3_type"]],
        mp3Title: json["mp3_title"],
        mp3Url: json["mp3_url"],
        mp3ThumbnailB: json["mp3_thumbnail_b"],
        mp3ThumbnailS: json["mp3_thumbnail_s"],
        mp3Duration: json["mp3_duration"],
        mp3Artist: json["mp3_artist"],
        mp3Description: json["mp3_description"],
        totalRate: json["total_rate"],
        rateAvg: json["rate_avg"],
        totalViews: json["total_views"],
        totalDownload: json["total_download"],
        cid: json["cid"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        categoryImageThumb: json["category_image_thumb"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "mp3_type": mp3TypeValues.reverse[mp3Type],
        "mp3_title": mp3Title,
        "mp3_url": mp3Url,
        "mp3_thumbnail_b": mp3ThumbnailB,
        "mp3_thumbnail_s": mp3ThumbnailS,
        "mp3_duration": mp3Duration,
        "mp3_artist": mp3Artist,
        "mp3_description": mp3Description,
        "total_rate": totalRate,
        "rate_avg": rateAvg,
        "total_views": totalViews,
        "total_download": totalDownload,
        "cid": cid,
        "category_name": categoryName,
        "category_image": categoryImage,
        "category_image_thumb": categoryImageThumb,
      };
}

enum Mp3Type { LOCAL }

final mp3TypeValues = EnumValues({"local": Mp3Type.LOCAL});




class LatestAlbum {
  LatestAlbum({
    required this.totalRecords,
    required this.aid,
    required this.albumName,
    required this.albumImage,
    required this.albumImageThumb,
  });

  final String totalRecords;
  final String aid;
  final String albumName;
  final String albumImage;
  final String albumImageThumb;

  factory LatestAlbum.fromJson(Map<String, dynamic> json) => LatestAlbum(
    totalRecords: json["total_records"] ?? '',
    aid: json["aid"] ??'',
    albumName: json["album_name"],
    albumImage: json["album_image"],
    albumImageThumb: json["album_image_thumb"],
  );

  Map<String, dynamic> toJson() => {
    "total_records": totalRecords,
    "aid": aid,
    "album_name": albumName,
    "album_image": albumImage,
    "album_image_thumb": albumImageThumb,
  };
}

class LatestArtist {
  LatestArtist({
    required this.id,
    required this.artistName,
    required this.artistImage,
    required this.artistImageThumb,
  });

  final String id;
  final String artistName;
  final String artistImage;
  final String artistImageThumb;

  factory LatestArtist.fromJson(Map<String, dynamic> json) => LatestArtist(
        id: json["id"],
        artistName: json["artist_name"],
        artistImage: json["artist_image"],
        artistImageThumb: json["artist_image_thumb"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "artist_name": artistName,
        "artist_image": artistImage,
        "artist_image_thumb": artistImageThumb,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}




