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

  Stream<List<Transaction>> transactionsStream() {
    return select(transactions).watch();
  }

  Stream<List<AccountType>> accountTypesStream() {
    return select(accountTypes).watch();
  }

  Stream<List<TransactionType>> transactionTypesStream() {
    return select(transactionTypes).watch();
  }

  Future<void> addTransaction(double amount) async {
    final query = select(accountTypes)..limit(1);
    final accountType = await query.get();
    final query2 = select(transactionTypes)..limit(1);
    final transactionType = await query2.get();
    final data = TransactionsCompanion.insert(
      accountType: accountType.first.id,
      transactionType: transactionType.first.id,
      amount: amount,
    );

    await transactions.insertOnConflictUpdate(data);
  }
}
