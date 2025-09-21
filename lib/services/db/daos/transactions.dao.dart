import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDao {
  TransactionDao(this._db);

  final Database _db;

  Future<List<Account>> getAccounts() async {
    final res = await _db.rawQuery('SELECT * FROM accounts');
    return res.map(Account.fromJson).toList();
  }

  Future<List<TxnType>> getTransactionTypes() async {
    final res = await _db.rawQuery('SELECT * FROM transaction_types');

    return res
        .map(
          (e) => TxnType.values.singleWhere((type) => type.id == e['id']),
        )
        .toList();
  }

  Future<void> addTransactions({
    required double amount,
    required int accountId,
    required int transactionTypeId,
    required DateTime? transactionAt,
    required int partyId,
    required String? description,
  }) {
    return _db.rawInsert(
      '''
INSERT INTO transactions 
(
description,
amount,
 transaction_at,
 account_id, 
 transaction_type_id,
 party_id
) 
VALUES 
(
?,
?,
?,
?,
?,
?
);
''',
      [
        description,
        amount,
        transactionAt?.toIso8601String(),
        accountId,
        transactionTypeId,
        partyId,
      ],
    );
  }

  Future<void> addAcount(String name) {
    return _db.rawInsert(
      'INSERT INTO accounts (name) Values (?);',
      [name],
    );
  }
}
