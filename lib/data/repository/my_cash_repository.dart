import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sertifikasi_bnsp/data/database/db_helper.dart';
import 'package:sertifikasi_bnsp/data/models/my_cash.dart';

class MyCashRepository {
  final database = DBHelper();
  final box = GetStorage();

  Future<int?> saveIncome(MyCash myCash) async {
    var dbClient = await database.db();
    return await dbClient!.insert('tableMyCash', myCash.toJson());
  }

  Future<List<MyCash>?> getAllMyCash() async {
    List<MyCash> listMyCash = [];
    var dbClient = await database.db();
    var result = await dbClient!.query('tableMyCash', columns: [
      'id',
      'user_id',
      'keterangan',
      'nominal',
      'tanggal_proses',
      'jenis_proses',
    ]);

    result.forEach((data) {
      //masukan data ke listKontak
      listMyCash.add(MyCash.fromJson(data));
    });

    debugPrint(listMyCash.toString());

    return listMyCash;
  }

  Future<Map<String, dynamic>> getMonthSummary() async {
    var dbClient = await database.db();
    List<MyCash> listMyCashIncome = [];
    List<MyCash> listMyCashExpenditure = [];

    // Get the current date
    DateTime now = DateTime.now();

    // // Get the first date of the current month
    // DateTime firstDateOfMonth = DateTime(now.year, now.month, 1);
    // // Get the end date of the current month
    // DateTime endDateOfMonth = DateTime(now.year, now.month + 1, 0);

    final firstDateOfMonth = DateTime(now.year, now.month, 1);
    final endDateOfMonth = DateTime(now.year, now.month + 1, 0);

    var pemasukan = await dbClient!
        // .query('tableMyCash',where: 'tanggal_proses >= ? and tanggal_proses <= ?',whereArgs: ["01/09/2023","23/09/2023"]);
        .rawQuery(
            '''SELECT * FROM tableMyCash WHERE user_id = ${box.read('userId')} AND jenis_proses = 'pemasukan' AND tanggal_proses BETWEEN ? AND ? ''',
            [
          firstDateOfMonth.toIso8601String(),
          endDateOfMonth.toIso8601String()
        ]);
    pemasukan.forEach((data) {
      //masukan data ke listKontak
      listMyCashIncome.add(MyCash.fromJson(data));
    });

    var pengeluaran = await dbClient
        // .query('tableMyCash',where: 'tanggal_proses >= ? and tanggal_proses <= ?',whereArgs: ["01/09/2023","23/09/2023"]);
        .rawQuery(
            '''SELECT * FROM tableMyCash WHERE user_id = ${box.read('userId')} AND jenis_proses = 'pengeluaran' AND tanggal_proses BETWEEN ? AND ? ''',
            [
          firstDateOfMonth.toIso8601String(),
          endDateOfMonth.toIso8601String()
        ]);
    pengeluaran.forEach((data) {
      //masukan data ke listKontak
      listMyCashExpenditure.add(MyCash.fromJson(data));
    });

    // debugPrint(listMyCashIncome.toString());
    int sumPemasukan = listMyCashIncome.fold(
        0,
        (previousValue, element) =>
            previousValue + int.parse(element.nominal!));
    int sumPengeluaran = listMyCashExpenditure.fold(
        0,
        (previousValue, element) =>
            previousValue + int.parse(element.nominal!));
    debugPrint("pemasukan = $sumPemasukan");
    debugPrint("pengeluaran2 = $sumPengeluaran");
    return {"pemasukan": sumPemasukan, "pengeluaran": sumPengeluaran};
  }

  Future<void> deleteCash(int id) async {
    var dbClient = await database.db();
    await dbClient!.delete('tableMyCash', where: 'id = ?', whereArgs: [id]);
  }
}
