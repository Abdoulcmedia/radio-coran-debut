// To parse this JSON data, do
//
//     final genersModel = genersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenersModel genersModelFromJson(String str) => GenersModel.fromJson(json.decode(str));

String genersModelToJson(GenersModel data) => json.encode(data.toJson());

class GenersModel {
  GenersModel({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory GenersModel.fromJson(Map<String, dynamic> json) => GenersModel(
    onlineMp3: List<OnlineMp3>.from(json["ONLINE_MP3"].map((x) => OnlineMp3.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ONLINE_MP3": List<dynamic>.from(onlineMp3.map((x) => x.toJson())),
  };
}

class OnlineMp3 {
  OnlineMp3({
    required this.totalRecords,
    required this.id,
    required this.genersName,
  });

  final String totalRecords;
  final String id;
  final String genersName;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    totalRecords: json["total_records"],
    id: json["id"],
    genersName: json["geners_name"],
  );

  Map<String, dynamic> toJson() => {
    "total_records": totalRecords,
    "id": id,
    "geners_name": genersName,
  };
}