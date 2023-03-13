// To parse this JSON data, do
//
//     final homeSectionModel = homeSectionModelFromJson(jsonString);

import 'dart:convert';

HomeSectionModel homeSectionModelFromJson(String str) => HomeSectionModel.fromJson(json.decode(str));

String homeSectionModelToJson(HomeSectionModel data) => json.encode(data.toJson());

class HomeSectionModel {
  HomeSectionModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory HomeSectionModel.fromJson(Map<String, dynamic> json) => HomeSectionModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.id,
    required this.sectionTitle,
    required this.songList,
  });

  final String id;
  final String sectionTitle;
  final String songList;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    id: json["id"],
    sectionTitle: json["section_title"],
    songList: json["song_list"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "section_title": sectionTitle,
    "song_list": songList,
  };
}
