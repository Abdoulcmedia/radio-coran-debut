// To parse this JSON data, do
//
//     final getUserUpdateModel = getUserUpdateModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetUserUpdateModel getUserUpdateModelFromJson(String str) => GetUserUpdateModel.fromJson(json.decode(str));

String getUserUpdateModelToJson(GetUserUpdateModel data) => json.encode(data.toJson());

class GetUserUpdateModel {
  GetUserUpdateModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory GetUserUpdateModel.fromJson(Map<String, dynamic> json) => GetUserUpdateModel(
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
    msg: json["msg"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "success": success,
  };
}
