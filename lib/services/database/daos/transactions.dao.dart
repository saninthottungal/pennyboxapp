import 'package:drift/drift.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/services/database/models/transaction.model.dart';
import 'package:pennyboxapp/services/database/tables/account_types.table.dart';
import 'package:pennyboxapp/services/database/tables/transaction_types.table.dart';
import 'package:pennyboxapp/services/database/tables/transactions.table.dart';

part 'transactions.dao.g.dart';

@DriftAccessor(
  tables: [
    AccountTypes,
    TransactionTypes,
    Transactions,
  ],
)
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(super.attachedDatabase);

  Stream<List<Transaction>> transactionsStream() {
    final query =
        select(transactions).join([
          innerJoin(
            accountTypes,
            accountTypes.id.equalsExp(transactions.accountType),
          ),
          innerJoin(
            transactionTypes,
            transactionTypes.id.equalsExp(transactions.transactionType),
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
          account: row.readTable(accountTypes),
          transactionType: row.readTable(transactionTypes),
        );
      }).toList();
    });
  }

  Future<List<AccountType>> getAccountTypes() {
    return select(accountTypes).get();
  }

  Future<List<TransactionType>> geTransactionTypes() {
    return select(transactionTypes).get();
  }

  Future<void> addTransaction({
    required double amount,
    required int accountTypeId,
    required int transactionTypeId,
  }) async {
    final data = TransactionRawCompanion.insert(
      amount: amount,
      accountType: accountTypeId,
      transactionType: transactionTypeId,
    );

    await transactions.insertOnConflictUpdate(data);
  }
}
