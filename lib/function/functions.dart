library functions;

import 'package:sqflite/sqflite.dart';

initializeDatabase() async{
  var databasesPath = await getDatabasesPath();
  String path = databasesPath+"/my_db.db";
  return await openDatabase(path);
}

initCheckTable(Database database) async{
  var wlt = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='wallet';");
  var txn = await database.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='transaction';");

  if(wlt.isEmpty) {
    database.execute("CREATE TABLE `walllet` (id INTEGER primary key, amount real, type text, `date` numeric, note text, category text)");
  }

  if (txn.isEmpty) {
    database.execute("CREATE TABLE `transaction` (id INTEGER primary key, amount real, type text, `date` numeric, note text, category text)");
  }
}


