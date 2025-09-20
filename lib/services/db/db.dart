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
        //* Accounts Table
        await db.execute('''
        CREATE TABLE IF NOT EXISTS accounts
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
        );
        ''');

        //* Transaction Types Table
        await db.execute('''
        CREATE TABLE IF NOT EXISTS transaction_types
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kind TEXT UNIQUE NOT NULL
        );
        ''');

        //* Parties Table
        await db.execute('''
        CREATE TABLE IF NOT EXISTS parties
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
        );
        ''');

        //* Transactions Table
        await db.execute('''
        CREATE TABLE IF NOT EXISTS transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        amount REAL CHECK (amount > 0),
        created_at TEXT NOT NULL  DEFAULT CURRENT_TIMESTAMP,
        transaction_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        account_id INTEGER NOT NULL REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
        transaction_type_id INTEGER NOT NULL REFERENCES transaction_types(id) ON DELETE CASCADE ON UPDATE CASCADE,
        party_id INTEGER  REFERENCES parties(id)  ON DELETE SET NULL ON UPDATE SET NULL
        );
        ''');

        //* Insert default values
        await db.rawInsert('INSERT INTO accounts (name) values ("Cash");');
        await db.rawInsert('''
        INSERT INTO transaction_types (kind) VALUES 
        ("Income"),
        ("Expense"),
        ("Transfer");
        ''');
      },
    );
  }
}
