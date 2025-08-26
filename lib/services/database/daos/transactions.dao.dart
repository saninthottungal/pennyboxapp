import 'package:drift/drift.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/services/database/models/account_with_balance.model.dart';
import 'package:pennyboxapp/services/database/models/transaction.model.dart';
import 'package:pennyboxapp/services/database/tables/accounts.table.dart';
import 'package:pennyboxapp/services/database/tables/transaction_types.table.dart';
import 'package:pennyboxapp/services/database/tables/transactions.table.dart';

part 'transactions.dao.g.dart';

@DriftAccessor(
  tables: [
    Accounts,
    TransactionTypes,
    Transactions,
  ],
  queries: {
    'queryGetAccountBalances': ''' 
     SELECT 
     AC.id,
     AC.name,
     SUM(CASE WHEN TY.id = 1 THEN T.amount ELSE 0 END) - 
     SUM(CASE WHEN TY.id != 1 THEN T.amount ELSE 0 END) as balance
     
     FROM transactions AS T
     JOIN
     accounts as AC
     ON T.account_id = AC.id
     JOIN
     transaction_types as TY
     ON T.transaction_type_id = TY.id
     GROUP BY AC.id;
    ''',
  },
)
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(super.attachedDatabase);

  Stream<List<Transaction>> transactionsStream() {
    final query =
        select(transactions).join([
          innerJoin(
            accounts,
            accounts.id.equalsExp(transactions.accountId),
          ),
          innerJoin(
            transactionTypes,
            transactionTypes.id.equalsExp(transactions.transactionTypeId),
          ),
        ])..orderBy([
          OrderingTerm.desc(transactions.createdAt),
        ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final t = row.readTable(transactions);

        return Transaction(
          id: t.id,
          amount: t.amount,
          createdAt: t.createdAt,
          description: t.description,
          account: row.readTable(accounts),
          transactionType: row.readTable(transactionTypes).asType,
        );
      }).toList();
    });
  }

  Future<List<Account>> getAccounts() {
    return select(accounts).get();
  }

  Future<List<TransactionType>> geTransactionTypes() {
    return select(transactionTypes).map((raw) => raw.asType).get();
  }

  Future<void> addTransaction({
    required double amount,
    required int accountId,
    required int transactionTypeId,
  }) async {
    final data = TransactionRawCompanion.insert(
      amount: amount,
      accountId: accountId,
      transactionTypeId: transactionTypeId,
    );

    await transactions.insertOnConflictUpdate(data);
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
}
