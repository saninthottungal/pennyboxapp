import 'package:drift/drift.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/services/database/models/account_with_balance.model.dart';
import 'package:pennyboxapp/services/database/models/transaction.model.dart';
import 'package:pennyboxapp/services/database/tables/accounts.table.dart';
import 'package:pennyboxapp/services/database/tables/parties.table.dart';
import 'package:pennyboxapp/services/database/tables/transaction_types.table.dart';
import 'package:pennyboxapp/services/database/tables/transactions.table.dart';

part 'transactions.dao.g.dart';

@DriftAccessor(
  tables: [
    Accounts,
    TransactionTypes,
    Transactions,
    Parties,
  ],
  queries: {
    'queryGetAccountBalances': '''
     SELECT 
     AC.id,
     AC.name,
     SUM(CASE WHEN TY.id = 1 THEN T.amount ELSE 0 END) - 
     SUM(CASE WHEN TY.id != 1 THEN T.amount ELSE 0 END) as balance

     FROM accounts as AC
     LEFT OUTER JOIN
     transactions as T
     ON AC.id = T.account_id
     LEFT OUTER JOIN
     transaction_types as TY
     ON T.transaction_type_id = TY.id
     GROUP BY AC.id
    ''',

    'queryHasPlannedTransactions': '''
    SELECT COUNT(*)
    FROM transactions
    where
    transaction_at > datetime('now');
    ''',
  },
)
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(super.attachedDatabase);

  Stream<List<Transaction>> transactionsStream({bool planned = false}) {
    var query =
        select(transactions).join([
          innerJoin(
            accounts,
            accounts.id.equalsExp(transactions.accountId),
          ),
          innerJoin(
            transactionTypes,
            transactionTypes.id.equalsExp(transactions.transactionTypeId),
          ),
          leftOuterJoin(parties, parties.id.equalsExp(transactions.partyId)),
        ])..orderBy([
          OrderingTerm.desc(transactions.transactionAt),
        ]);

    if (planned) {
      query = query
        ..where(transactions.transactionAt.isBiggerThan(currentDateAndTime));
    } else {
      query = query
        ..where(
          transactions.transactionAt.isSmallerOrEqual(currentDateAndTime),
        );
    }

    return query.watch().map((rows) {
      return rows.map((row) {
        final t = row.readTable(transactions);

        return Transaction(
          id: t.id,
          amount: t.amount,
          transactionAt: t.transactionAt,
          description: t.description,
          account: row.readTable(accounts),
          type: row.readTable(transactionTypes).asType,
          party: row.readTableOrNull(parties),
        );
      }).toList();
    });
  }

  Stream<int> hasPlannedTransactionsStream() {
    return queryHasPlannedTransactions().watchSingle();
  }

  Future<List<Account>> getAccounts() {
    return select(accounts).get();
  }

  Future<List<TxnType>> geTransactionTypes() {
    return select(transactionTypes).map((raw) => raw.asType).get();
  }

  Future<void> addTransaction({
    required double amount,
    required int accountId,
    required int transactionTypeId,
    required DateTime? transactionAt,
    required int partyId,
    required String? description,
  }) async {
    final data = TransactionRawCompanion.insert(
      amount: amount,
      accountId: accountId,
      transactionTypeId: transactionTypeId,
      transactionAt: Value.absentIfNull(transactionAt),
      partyId: Value.absentIfNull(partyId),
      description: Value.absentIfNull(description),
    );

    await transactions.insert().insert(data);
  }

  Stream<List<AccountwBalance>> getAccountBalances() {
    return queryGetAccountBalances().watch().map((accounts) {
      return accounts.map((e) {
        return AccountwBalance(
          id: e.id,
          accountName: e.name,
          balance: e.balance ?? 0,
        );
      }).toList();
    });
  }

  Future<int> addAccount(String accountName) {
    return accounts.insert().insert(
      AccountsCompanion.insert(name: accountName),
    );
  }

  Future<int> deleteTransaction(int id) {
    return transactions.deleteWhere((e) => e.id.equals(id));
  }

  Future<int> deleteAccount(int id) {
    return accounts.deleteWhere((e) => e.id.equals(id));
  }

  Stream<List<Party>> getParties({String search = ''}) {
    return (select(parties)..where((e) => e.name.like('%$search%'))).watch();
  }

  Future<int> addParty(String name) {
    return parties.insertOne(PartyCompanion.insert(name: name));
  }

  Future<int> deleteParty(int id) {
    return parties.deleteWhere((e) => e.id.equals(id));
  }
}
