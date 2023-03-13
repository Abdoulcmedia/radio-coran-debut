// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    this.userId,
    this.name,
    this.email,
    this.msg,
    this.authId,
    this.success,
  });

  final String? userId;
  final String? name;
  final String? email;
  final String? msg;
  final String? authId;
  final String? success;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    userId: json["user_id"] ?? "",
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    msg: json["msg"] ?? "",
    authId: json["auth_id"] ?? "",
    success: json["success"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "email": email,
    "msg": msg,
    "auth_id": authId,
    "success": success,
  };
}
