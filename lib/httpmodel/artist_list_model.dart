
import 'dart:convert';

ArtistList artistListFromJson(String str) => ArtistList.fromJson(json.decode(str));

String artistListToJson(ArtistList data) => json.encode(data.toJson());

class ArtistList {
  ArtistList({
    required this.onlineMp3,
  });

  final List<OnlineMp3> onlineMp3;

  factory ArtistList.fromJson(Map<String, dynamic> json) => ArtistList(
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
    required this.artistName,
    required this.artistImage,
    required this.artistImageThumb,
  });

  final String totalRecords;
  final String id;
  final String artistName;
  final String artistImage;
  final String artistImageThumb;

  factory OnlineMp3.fromJson(Map<String, dynamic> json) => OnlineMp3(
    totalRecords: json["total_records"],
    id: json["id"],
    artistName: json["artist_name"],
    artistImage: json["artist_image"],
    artistImageThumb: json["artist_image_thumb"],
  );

  Map<String, dynamic> toJson() => {
    "total_records": totalRecords,
    "id": id,
    "artist_name": artistName,
    "artist_image": artistImage,
    "artist_image_thumb": artistImageThumb,
  };
}
