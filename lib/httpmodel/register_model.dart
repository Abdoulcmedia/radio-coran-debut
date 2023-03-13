// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.userId,
    required this.msg,
    required this.success,
  });

  final String userId;
  final String msg;
  final String success;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    userId: json["user_id"],
    msg: json["msg"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "msg": msg,
    "success": success,
  };
}
