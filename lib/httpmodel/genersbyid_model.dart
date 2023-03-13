// To parse this JSON data, do
//
//     final genersModelById = genersModelByIdFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenersModelById genersModelByIdFromJson(String str) => GenersModelById.fromJson(json.decode(str));

String genersModelByIdToJson(GenersModelById data) => json.encode(data.toJson());

class GenersModelById {
  GenersModelById({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory GenersModelById.fromJson(Map<String, dynamic> json) => GenersModelById(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.totalRecords,
    required this.pid,
    required this.genersType,
    required this.playlistName,
    required this.playlistImage,
    required this.playlistImageThumb,
  });

  final String totalRecords;
  final String pid;
  final String genersType;
  final String playlistName;
  final String playlistImage;
  final String playlistImageThumb;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    totalRecords: json["total_records"],
    pid: json["pid"],
    genersType: json["geners_type"],
    playlistName: json["playlist_name"],
    playlistImage: json["playlist_image"],
    playlistImageThumb: json["playlist_image_thumb"],
  );

  Map<String, dynamic> toJson() => {
    "total_records": totalRecords,
    "pid": pid,
    "geners_type": genersType,
    "playlist_name": playlistName,
    "playlist_image": playlistImage,
    "playlist_image_thumb": playlistImageThumb,
  };
}
