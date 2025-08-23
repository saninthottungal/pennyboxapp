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
}
