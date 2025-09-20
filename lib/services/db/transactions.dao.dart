import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:sqflite/sqflite.dart';

part 'transactions.dao.g.dart';
part 'transactions.dao.freezed.dart';

@freezed
abstract class Account with _$Account {
  const factory Account({
    required int id,
    required String name,
  }) = _Account;

  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);
}

class TransactionDao {
  TransactionDao(this._db);

  final AppSqfliteDb _db;

  Future<void> createTables(Database db) {
    return db.execute('''
CREATE TABLE IF NOT EXISTS  accounts
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS transaction_types
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
kind TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS parties
(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT UNIQUE NOT NULL
);


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
  }

  Future<void> insertDefaultTnxTypesAndAccounts(Database db) {
    return db.execute(
      '''
INSERT INTO accounts (name) values (?);
INSERT INTO transaction_types (kind) VALUES (?),(?),(?);

    ''',
      ["Cash", "Income", "Expense", "Transfer"],
    );
  }
}
