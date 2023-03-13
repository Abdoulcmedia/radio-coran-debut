import 'dart:convert';

AlbumList albumListFromJson(String str) => AlbumList.fromJson(json.decode(str));

String albumListToJson(AlbumList data) => json.encode(data.toJson());

class AlbumList {
  AlbumList({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory AlbumList.fromJson(Map<String, dynamic> json) => AlbumList(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
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

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    totalRecords: json["total_records"],
    aid: json["aid"],
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
