import 'package:sqflite/sqflite.dart';

class AppDatabase {
  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._();

  static final _instance = AppDatabase._();

  late final Database _db;
  Database get db => _db;

  Future<Database> open() async {
    return _db = await openDatabase('manager.db');
  }
}
