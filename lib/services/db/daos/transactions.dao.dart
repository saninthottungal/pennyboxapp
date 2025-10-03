import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/daos/transactions.queries.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart' as model;
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class TnxDao {
  TnxDao(this._db);

  final Database _db;

  Future<List<Account>> getAccounts() async {
    final res = await _db.rawQuery(TnxQuery.getAccounts);
    return res.map(Account.fromJson).toList();
  }

  Future<List<TxnType>> getTransactionTypes() async {
    final res = await _db.rawQuery(TnxQuery.getTransactionTypes);

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
      TnxQuery.addTransaction,
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
    return _db.rawInsert(TnxQuery.addAccount, [name]);
  }

  Future<void> deleteAccount(int id) {
    return _db.rawDelete(TnxQuery.deleteAccount, [id]);
  }

  Future<List<Party>> getParties({String search = ''}) async {
    final res = await _db.rawQuery(
      TnxQuery.getParties,
      ['%$search%'],
    );
    return res.map(Party.fromJson).toList();
  }

  Future<void> addParty(String name) {
    return _db.rawInsert(TnxQuery.addParty, [name]);
  }

  Future<void> deleteParty(int id) {
    return _db.rawDelete(TnxQuery.deleteParty, [id]);
  }

  Future<List<AccountwBalance>> getAccountBalances() async {
    final res = await _db.rawQuery(TnxQuery.getAccountBalances);

    return res.map(AccountwBalance.fromJson).toList();
  }

  Future<void> deleteTransaction({
    required int? id,
    required String? transferId,
  }) async {
    if (id != null) {
      await _db.rawDelete(TnxQuery.deleteTnxOnId, [id]);
    } else if (transferId != null) {
      await _db.rawDelete(
        TnxQuery.deleteTnxOnTransferId,
        [transferId],
      );
    }
  }

  Future<List<model.Transaction>> getTransactions({
    bool isPlanned = false,
    int? limit,
  }) async {
    final res = await _db.rawQuery(
      TnxQuery.getTransactions(
        limit: limit,
        isPlanned: isPlanned,
      ),
    );

    return res.map((row) {
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
      final transferredTo = row['transferred_to_account_id'] != null
          ? Account(
              id: row['transferred_to_account_id']! as int,
              name: row['transferred_to_account_name']! as String,
            )
          : null;
      return model.Transaction(
        id: row['id']! is int ? row['id']!.toString() : row['id']! as String,
        amount: row['amount']! as double,
        account: account,
        type: type,
        transactionAt: DateTime.parse(
          row['transaction_at']! as String,
        ).toLocal(),
        party: party,
        transferredTo: transferredTo,
        description: row['description'] as String?,
      );
    }).toList();
  }

  Future<model.Transaction?> getSingleTransaction(dynamic transactionId) async {
    final res = await _db.rawQuery(
      TnxQuery.getSingleTransaction,
      [transactionId],
    );
    final tnx = res.singleOrNull;
    if (tnx == null) return null;

    final account = Account(
      id: tnx['account_id']! as int,
      name: tnx['account_name']! as String,
    );

    final type = TxnType.fromId(tnx['transaction_type_id']! as int);

    final party = tnx['party_id'] != null
        ? Party(
            id: tnx['party_id']! as int,
            name: tnx['party_name']! as String,
          )
        : null;
    final transferredTo = tnx['transferred_to_account_id'] != null
        ? Account(
            id: tnx['transferred_to_account_id']! as int,
            name: tnx['transferred_to_account_name']! as String,
          )
        : null;
    return model.Transaction(
      id: tnx['id']! is int ? tnx['id']!.toString() : tnx['id']! as String,
      amount: tnx['amount']! as double,
      account: account,
      type: type,
      transactionAt: DateTime.parse(
        tnx['transaction_at']! as String,
      ).toLocal(),
      party: party,
      transferredTo: transferredTo,
      description: tnx['description'] as String?,
    );
  }
}
