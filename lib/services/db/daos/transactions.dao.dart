import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart' as model;
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

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

  Future<void> addTransferTransaction({
    required double amount,
    required int fromAccountId,
    required int toAccountId,
    required DateTime? transactionAt,
    required String? description,
  }) async {
    if (fromAccountId == toAccountId) {
      throw Exception("Tried transferring to self account");
    }

    await _db.transaction((tnx) async {
      final transferId = const Uuid().v4();

      await addTransaction(
        amount: amount,
        accountId: fromAccountId,
        transactionTypeId: TxnType.expense.id,
        transactionAt: transactionAt,
        partyId: null,
        transferId: transferId,
        description: description,
        tnx: tnx,
      );

      await addTransaction(
        amount: amount,
        accountId: toAccountId,
        transactionTypeId: TxnType.income.id,
        //* adding a small duration difference between both transaction for sorting better
        transactionAt: transactionAt?.add(const Duration(milliseconds: 500)),
        partyId: null,
        transferId: transferId,
        description: description,
        tnx: tnx,
      );
    });
  }

  Future<void> addTransaction({
    required double amount,
    required int accountId,
    required int transactionTypeId,
    required DateTime? transactionAt,
    required int? partyId,
    required String? transferId,
    required String? description,
    Transaction? tnx,
  }) {
    return (tnx ?? _db).rawInsert(
      '''
INSERT INTO transactions 
(
description,
amount,
transaction_at,
account_id, 
transaction_type_id,
party_id,
transfer_id
) 
VALUES 
(
?,
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
        transactionAt?.toUtc().toIso8601String(),
        accountId,
        transactionTypeId,
        partyId,
        transferId,
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

SELECT AC.id, AC.name as account_name, 
coalesce(SUM(CASE WHEN TXNTYPE.kind = 'Income'  
THEN TXN.amount ELSE 0
 END),0) -
coalesce(SUM(CASE WHEN TXNTYPE.kind != 'Income' 
THEN TXN.amount ELSE 0
 END),0) 
 AS balance,

coalesce(SUM(CASE WHEN TXNTYPE.kind = 'Income' 
AND TXN.transaction_at <=strftime('%Y-%m-%dT%H:%M:%fZ', 'now') 
 THEN TXN.amount ELSE 0 END),0) - 
 coalesce(SUM(CASE WHEN TXNTYPE.kind != 'Income' 
 AND TXN.transaction_at <=strftime('%Y-%m-%dT%H:%M:%fZ', 'now') 
 THEN TXN.amount ELSE 0 END),0)
 AS actual_balance

FROM accounts AS AC
LEFT OUTER JOIN
transactions AS TXN
ON AC.id = TXN.account_id
LEFT OUTER JOIN
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
    int? limit,
  }) async {
    final limitClause = limit != null ? 'LIMIT $limit' : '';

    final res = await _db.rawQuery('''
SELECT 

T.id, 
T.amount, 
T.description, 
T.transfer_id,
AC.id AS account_id,
AC.name AS account_name,
TY.id AS transaction_type_id,
TY.kind AS transaction_type,
T.transaction_at,
P.id AS party_id,
P.name AS party_name,
AC2.id  AS transfer_account_id,
AC2.name AS transfer_account_name

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
LEFT OUTER JOIN
transactions AS T2
ON T.transfer_id = T2.transfer_id
AND T.id != T2.id
LEFT OUTER JOIN 
accounts AS AC2
ON T2.account_id = AC2.id

ORDER BY T.transaction_at DESC
$limitClause;
''');

    final transactions = res.map((row) {
      final account = Account(
        id: row['account_id']! as int,
        name: row['account_name']! as String,
      );

      final type = TxnType.fromId(row['transaction_type_id']! as int);

      final party = row['party_id'] != null
          ? Party(
              id: row['party_id']! as int,
              name: row['party_name']! as String,
            )
          : null;
      final transferredTo = row['transfer_account_id'] != null
          ? Account(
              id: row['transfer_account_id']! as int,
              name: row['transfer_account_name']! as String,
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
        transferredTo: transferredTo,
      );
    });

    //TODO: filtering should be on the sql level
    if (isPlanned) {
      return transactions
          .where((e) => e.transactionAt.isAfter(DateTime.now()))
          .toList();
    }
    return transactions
        .where((e) => e.transactionAt.isBefore(DateTime.now()))
        .toList();
  }
}
