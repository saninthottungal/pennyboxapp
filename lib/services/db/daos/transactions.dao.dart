import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart' as model;
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

    return res.map((row) => TxnType.fromId(row['id']! as int)).toList();
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

  Future<void> addAccount(String name) {
    return _db.rawInsert(
      'INSERT INTO accounts (name) Values (?);',
      [name],
    );
  }

  Future<void> deleteAccount(int id) {
    return _db.rawDelete(
      'DELETE FROM accounts WHERE id = ?;',
      [id],
    );
  }

  Future<List<Party>> getParties({String search = ''}) async {
    final res = await _db.rawQuery(
      "SELECT * FROM parties WHERE name LIKE ?;",
      ['%$search%'],
    );
    return res.map(Party.fromJson).toList();
  }

  Future<void> addParty(String name) {
    return _db.rawInsert(
      'INSERT INTO parties (name) VALUES (?);',
      [name],
    );
  }

  Future<void> deleteParty(int id) {
    return _db.rawDelete(
      'DELETE FROM parties WHERE id = ?',
      [id],
    );
  }

  Future<List<AccountwBalance>> getAccountBalances() async {
    final res = await _db.rawQuery('''
SELECT AC.id, AC.name, 
SUM(CASE WHEN TXNTYPE.kind = 'Income'  THEN TXN.amount ELSE 0 END ) -
SUM(CASE WHEN TXNTYPE.kind != 'Income' THEN TXN.amount ELSE 0 END) AS balance
FROM accounts AS AC
LEFT OUTER JOIN
transactions AS TXN
ON AC.id = TXN.account_id
INNER JOIN 
transaction_types AS TXNTYPE
ON TXNTYPE.id = TXN.transaction_type_id
GROUP BY AC.id;
''');

    return res.map(AccountwBalance.fromJson).toList();
  }

  Future<void> deleteTransaction(int id) {
    return _db.rawDelete(
      'DELETE FROM transactions WHERE id = ?',
      [id],
    );
  }

  Future<List<model.Transaction>> getTransactions({
    bool isPlanned = false,
  }) async {
    final op = isPlanned ? '>' : '<=';

    final res = await _db.rawQuery('''
SELECT 

T.id, 
T.amount, 
T.description, 
AC.id as account_id,
AC.name as account_name,
TY.id as transaction_type_id,
TY.kind as transaction_type,
T.transaction_at,
P.id as party_id,
P.name as party_name

FROM 
transactions AS T
INNER JOIN
accounts AS AC
ON T.account_id = AC.id
INNER JOIN
transaction_types AS TY
ON T.transaction_type_id = TY.id
LEFT OUTER JOIN
parties AS P
ON T.party_id = P.id 
WHERE
T.transaction_at $op CURRENT_TIMESTAMP;
''');

    return res.map((row) {
      final account = Account(
        id: row['account_id']! as int,
        name: row['account_name']! as String,
      );

      final type = TxnType.fromId(row['transaction_type']! as int);

      final party = row['party_id'] != null
          ? Party(
              id: row['party_id']! as int,
              name: row['party_name']! as String,
            )
          : null;
      return model.Transaction(
        id: row['id']! as int,
        amount: row['amount']! as double,
        account: account,
        type: type,
        transactionAt: DateTime.parse(
          row['transaction_at']! as String,
        ).toLocal(),
        party: party,
      );
    }).toList();
  }
}
