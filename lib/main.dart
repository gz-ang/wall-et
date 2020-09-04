import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet/pages/splash.dart';

import 'model/database.dart';
import 'model/transaction.dart';
import 'model/wallet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WalletRepo>(create: (context) => WalletRepo()),
        ChangeNotifierProvider<TransactionRepo>(create: (context) => TransactionRepo()),
        ChangeNotifierProvider<LocalDatabase>(create: (context) => LocalDatabase())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database database;

  _rundb() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "/my_db.db";
    return await openDatabase(path, version: 1);
  }

  _createTable() async {
    return database.execute(
        "CREATE TABLE `transaction` (id INTEGER primary key, amount real, type text, `date` numeric, note text, category text)");
  }

  _sqlSelect() async {
    return database.query("`transaction`");
  }

  _sqlInsert() async {
    return database.rawInsert(
        "insert into `transaction` (amount, type, `date`, note, category) VALUES (?,?,?,?,?)",
        [1.50, 'credit', "2020-09-03 13:00:10", 'lunch', "food"]);
//    database.execute("INSERT INTO test (name, value, num) VALUES ('some name', 1234, 12.34)");
  }

  _sqlUpdate() async {
    String col1 = "type";
    String col2 = "id";
    return database.rawUpdate(
        "UPDATE `transaction` SET $col1=? WHERE $col2=?", ["credit", 1]);
//    database.execute("UPDATE test SET name='my_name' WHERE ID = 1");
  }

  _sqlDelete() async {
    return database.rawDelete("DELETE FROM test WHERE name=?", ["agz"]);
//    database.execute("DELETE FROM test WHERE ID = 2");
  }

  _deleteTable() async {
    return database.execute("DROP TABLE test");
  }

  _closedb() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "/my_db.db";
    return await deleteDatabase(path);
  }

  _checktable() async {
    return database.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='transaction';");
  }

  @override
  Widget build(BuildContext context) {
    print(database);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DateTime dt = new DateTime.now();
          print(dt);
          setState(() {});
          print("database: $database");
          await database.getVersion().then((value) => print("version: $value"));
          print("path: ${database.path}");
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                var v = _rundb();
                v.then((value) => database = value);
              },
              child: Text("create db"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _createTable();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("create table"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _checktable();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("check table"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _sqlSelect();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("select"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _sqlInsert();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("insert"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _sqlUpdate();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("update"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _sqlDelete();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("delete"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _deleteTable();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("drop table"),
            ),
            RaisedButton(
              onPressed: () {
                var res = _closedb();
                print(res);
                res.then((value) => print(value));
              },
              child: Text("deletedb"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
