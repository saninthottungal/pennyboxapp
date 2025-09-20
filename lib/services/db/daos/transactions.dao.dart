import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDao {
  TransactionDao(this._db);

  final Database _db;

  Future<List<Account>> getAccounts() async {
    final res = await _db.rawQuery('SELECT * FROM accounts');
    return res.map(Account.fromJson).toList();
  }
}
