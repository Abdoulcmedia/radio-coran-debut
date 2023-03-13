// To parse this JSON data, do
//
//     final favouriteModel = favouriteModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavouriteModel favouriteModelFromJson(String str) => FavouriteModel.fromJson(json.decode(str));

String favouriteModelToJson(FavouriteModel data) => json.encode(data.toJson());

class FavouriteModel {
  FavouriteModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.msg,
    required this.success,
  });

  final String msg;
  final String success;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    msg: json["MSG"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "MSG": msg,
    "success": success,
  };
}
