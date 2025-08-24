import 'package:drift/drift.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
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

  Stream<List<TransactionRaw>> transactionsStream() {
    final query = select(transactions)
      ..orderBy([
        (t) => OrderingTerm.desc(t.createdAt),
      ])
      ..join([]);

    return query.watch();
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
