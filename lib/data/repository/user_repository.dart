import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sertifikasi_bnsp/data/database/db_helper.dart';
import 'package:sertifikasi_bnsp/data/models/user.dart';

class UserRepository {
  final database = DBHelper();
  final box = GetStorage();

  Future<int?> saveUser(User user) async {
    var dbClient = await database.db();
    return await dbClient!.insert('tableUser', user.toJson());
  }

  Future<List<User>?> getAllUser() async {
    List<User> listUser = [];
    var dbClient = await database.db();
    var result = await dbClient!
        .query('tableUser', columns: ['id', 'username', 'password']);

    result.forEach((kontak) {
      //masukan data ke listKontak
      listUser.add(User.fromJson(kontak));
    });

    return listUser;
  }

  Future<bool> login(User user) async {
    var dbClient = await database.db();
    var res = await dbClient!.rawQuery(
        "SELECT * FROM tableUser WHERE username = '${user.username}' and password = '${user.password}'");
    debugPrint(res.toString());
    if (res.isNotEmpty) {
      User tempUser = User.fromJson(res.first);
      debugPrint("login sukses = ${tempUser}");
      box.write('userId', tempUser.id);
      return true;
    } else {
      debugPrint("login gagal");
      return false;
    }
  }

  Future<Map<String,dynamic>> changePassword(String oldPassword, String newPassword) async {
    var dbClient = await database.db();
    var userId = getUserId();
    var res = await dbClient!
        .rawQuery("SELECT * FROM tableUser WHERE id = '$userId'");
    User tempUser = User.fromJson(res.first);
    debugPrint(tempUser.toString());
    if (oldPassword == tempUser.password) {
      await dbClient.update('tableUser', {'password': newPassword},
          where: 'id = ?', whereArgs: [userId]);
      return {
        "status": true,
        "message":"Ubah password berhasil !!"
      };
    } else {
      return {
        "status": false,
        "message":"Password saat ini tidak sesuai"
      };
    }
  }

  dynamic getUserId() {
    return box.read('userId');
  }

  dynamic deleteUserId() {
    return box.remove('userId');
  }
}
