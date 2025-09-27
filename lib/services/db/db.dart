import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db_migrations.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._();

  static final _instance = AppDatabase._();

  late final Database _db;
  Database get db => _db;

  late final TransactionDao transactionDao;

  Future<Database> open() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final String path;

    if (kDebugMode) {
      path = '/Users/paiteq/Developer/personal/dbs/pennybox.sqlite';
    } else {
      path = join(dbFolder.path, 'pennyboxdb.sqlite');
    }

    _db = await openDatabase(
      path,
      version: 2,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          for (final query in DbMigrations.queries[i] ?? <String>[]) {
            await db.execute(query);
          }
        }
      },
    );

    transactionDao = TransactionDao(_db);
    return _db;
  }
}
