import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pennyboxapp/services/db/transactions.dao.dart';
import 'package:sqflite/sqflite.dart';

class AppSqfliteDb {
  factory AppSqfliteDb() {
    return _instance;
  }

  AppSqfliteDb._() {
    transactionDao = TransactionDao(this);
  }

  static final _instance = AppSqfliteDb._();

  late final Database _rawDb;
  Database get rawDb => _rawDb;

  late final TransactionDao transactionDao;

  Future<Database> open() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final String path;
    if (kDebugMode) {
      path = '/Users/paiteq/Developer/pennybox_debug.db';
    } else {
      path = join(dbFolder.path, 'pennybox.db');
    }

    return _rawDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await transactionDao.createTables(db);
        await transactionDao.insertDefaultTnxTypesAndAccounts(db);
      },
    );
  }
}
