library functions;

import 'package:sqflite/sqflite.dart';

initializeDatabase() async{
  var databasesPath = await getDatabasesPath();
  String path = databasesPath+"/my_db.db";
  return await openDatabase(path);
}

