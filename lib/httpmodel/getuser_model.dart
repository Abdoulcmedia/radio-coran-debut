// To parse this JSON data, do
//
//     final getUserModel = getUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetUserModel getUserModelFromJson(String str) => GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  GetUserModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.userImage,
    required this.userYoutube,
    required this.userInstagram,
    required this.isVerified,
    required this.success,
  });

  final String userId;
  final String name;
  final String email;
  final String phone;
  final String userImage;
  final dynamic userYoutube;
  final dynamic userInstagram;
  final String isVerified;
  final String success;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    userImage: json["user_image"],
    userYoutube: json["user_youtube"],
    userInstagram: json["user_instagram"],
    isVerified: json["is_verified"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "email": email,
    "phone": phone,
    "user_image": userImage,
    "user_youtube": userYoutube,
    "user_instagram": userInstagram,
    "is_verified": isVerified,
    "success": success,
  };
}
