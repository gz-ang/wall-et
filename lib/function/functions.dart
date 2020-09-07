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
    await database.execute("CREATE TABLE `wallet` (`id` INTEGER PRIMARY KEY, `name` TEXT, `balance` REAL)");
  }

  if (txn.isEmpty) {
    print("Creating table: transaction");
    await database.execute("CREATE TABLE `transaction` (`id` INTEGER PRIMARY KEY, `amount` REAL, `type` TEXT, `date` NUMERIC, `note` TEXT, `category` TEXT, `wallet` TEXT)");
  }
  return [wlt, txn];
}

getData(Database database) async{
  var wlt = await database.query("`wallet`");
  var txn = await database.query("`transaction`");
  if (wlt.isEmpty) {
    return null;
  } else {
    return [wlt, txn];
  }

}

createWallet(Database database, String name, double balance) async{
  return database.rawInsert(
      "INSERT INTO `wallet` (name, balance) SELECT ?,? WHERE NOT EXISTS (SELECT * FROM `wallet` WHERE name = '$name')",
      [name, balance]);
}

updateWallet(Database database, walletName, walletAmount) async{
  var wlt = await database.rawUpdate("UPDATE `wallet` SET `name`=?, `balance`=? WHERE `name`=$walletName", [walletName, walletAmount]);
  //TODO: update for transactions if transaction exist
  //TODO: Alternative, change col in transaction into id

}

deleteWallet(Database database, walletName) async{
  return database.rawDelete("DELETE FROM `wallet` WHERE `name` = ?", [walletName]);
  //TODO: logic, delete transaction associated with this wallet
}

addTransaction(Database database) async{

}

editTransaction(Database database) async{

}

deleteTransaction(Database database) async{

}




