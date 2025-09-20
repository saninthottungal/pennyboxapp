import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pennyboxapp/services/db/db.dart';

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

  Future<void> createTables() async {
    _db.rawDb.execute('''
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





''');
  }
}
