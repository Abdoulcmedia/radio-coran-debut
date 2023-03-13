import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../httpmodel/download_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'database.db');

    if (kDebugMode) {
      print('path::::==== $path');
    }
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE DownloadSong (id INTEGER,songid INTEGER ,link TEXT, artist TEXT ,imagepath TEXT,userId TEXT,songname TEXT, PRIMARY KEY(id AUTOINCREMENT))');

    if (kDebugMode) {
      print('::::Table Create::::');
    }
  }

  Future<bool> isdownload(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('DownloadSong', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty ? true : false;
  }

  Future addDownload(DownloadSong dSongs) async {
    var db = await database;
    dSongs.id = await db!.insert('DownloadSong', dSongs.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    if (kDebugMode) {
      print('Song Download Successfully...${dSongs.title}');
    }
    return dSongs;
  }

  Future<List<DownloadSong>> getDownloadSongs({required userId}) async {
    var db = await database;
    List<Map> maps = await db!.query('DownloadSong',
        where: 'userId = ?', whereArgs: [userId], columns: ['id', 'songid', 'artist', 'link', 'imagepath', 'userId', 'songname']);

    List<DownloadSong> downloadsong = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        downloadsong.add(DownloadSong.fromMap(maps[i]));
      }
    }
    return downloadsong;
  }

  Future<int> deleteDownloadSongs(int id) async {
    var db = await database;
    return await db!.delete(
      'DownloadSong',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
