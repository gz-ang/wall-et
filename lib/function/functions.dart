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
    print("Creating table: wallet");
    await database.execute("CREATE TABLE `walllet` (`id` INTEGER PRIMARY KEY, `name` TEXT, `balance` REAL)");
  }

  if (txn.isEmpty) {
    print("Creating table: transaction");
    await database.execute("CREATE TABLE `transaction` (`id` INTEGER PRIMARY KEY, `amount` REAL, `type` TEXT, `date` NUMERIC, `note` TEXT, `category` TEXT)");
  }
}

getData(Database database) async{
  var wlt = await database.query("`wallet`");
  var txn = await database.query("`transaction`");

  return [wlt, txn];
}


