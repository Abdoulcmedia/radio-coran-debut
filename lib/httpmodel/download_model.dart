class DownloadSong {
  int? id;
  int? songid;
  String? link;
  String? artist;
  String? imagepath;
  String? userId;
  String? title;

  DownloadSong({this.id, this.link, this.artist, this.imagepath, this.songid, this.userId, this.title});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'songid': songid,
      'artist': artist,
      'imagepath': imagepath,
      'link': link,
      'userId': userId,
      'songname': title
    };
    return map;
  }

  DownloadSong.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    songid = map['songid'];
    artist = map['artist'];
    imagepath = map['imagepath'];
    link = map['link'];
    title = map['songname'];
  }
}
