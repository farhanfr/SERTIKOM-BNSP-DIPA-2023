//dbhelper ini dibuat untuk
//membuat database, membuat tabel, proses insert, read, update dan delete

import 'package:flutter/foundation.dart';
import 'package:sertifikasi_bnsp/data/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();
  factory DBHelper() => _instance;

  //cek apakah database ada
  Future<Database?> db() async {
    // getDat
      if (_database != null) {
          return _database;
      }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mycashbook.db');
    //await deleteDatabase(path); //HAPUS SAAT TABEL SUDAH BENAR , KODE INI HANYA UNTUK DEV
    // debugPrint("TESSSS");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var tableUser = "CREATE TABLE tableUser(id INTEGER PRIMARY KEY, "
        "username TEXT,"
        "password TEXT)";

    var tableMyCash = "CREATE TABLE tableMyCash(id INTEGER PRIMARY KEY, "
        "user_id TEXT,"
        "nominal TEXT,"
        "keterangan TEXT,"
        "tanggal_proses TEXT,"
        "jenis_proses TEXT)";

    await db.execute(tableUser);
    await db.execute(tableMyCash);
  }

  // Future<int?> saveUser(User user) async {
  //   var dbClient = await db();
  //   return await dbClient!.insert('tableUser', user.toJson());
  // }

  // //read database
  // Future<List?> getAllUser() async {
  //   var dbClient = await db();
  //   var result = await dbClient!.query('tableUser', columns: [
  //     'id',
  //     'username',
  //     'password'
  //   ]);

  //   return result.toList();
  // }

  //update database
  // Future<int?> updateKontak(Kontak kontak) async {
  //   var dbClient = await _db;
  //   return await dbClient!.update(tableName, kontak.toJson(),
  //       where: '$columnId = ?', whereArgs: [kontak.id]);
  // }

  // //hapus database
  // Future<int?> deleteKontak(int id) async {
  //   var dbClient = await _db;
  //   return await dbClient!
  //       .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  // }

}
