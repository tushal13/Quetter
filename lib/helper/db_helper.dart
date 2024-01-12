import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../views/modal/quate_modal.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  late Database dbase;

  String dwonloadDB = 'download';
  String dwonloadid = 'Id';
  String dwonloadquote = 'Quotes';
  String dwonloadauthor = 'Author';
  String dwonloadimage = 'Image';

  initDb() async {
    String dbpath = await getDatabasesPath();
    String dbname = 'quette.db';
    String path = join(dbpath + dbname);
    dbase = await openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE IF NOT EXISTS $dwonloadDB($dwonloadid TEXT, $dwonloadquote TEXT, $dwonloadauthor TEXT)",
      );
    });
  }

  insertDwonload({required QuoteModal quote}) async {
    String query =
        'INSERT INTO $dwonloadDB($dwonloadid,$dwonloadquote, $dwonloadauthor) VALUES(?,?,?)';
    List args = [
      quote.id,
      quote.quote,
      quote.author,
    ];
    return await dbase.rawInsert(query, args);
  }

  getDwonload() async {
    String query = 'SELECT * FROM $dwonloadDB';
    List allData = await dbase.rawQuery(query);

    List<QuoteModal> allDwonload =
        allData.map((e) => QuoteModal.fromMAp(quote: e)).toList();
    log(allDwonload.toString());
    return allDwonload;
  }
}
