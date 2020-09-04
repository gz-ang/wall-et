import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase with ChangeNotifier {
  Database database;

  setDatabase( data ) {
    database = data;
  }

}