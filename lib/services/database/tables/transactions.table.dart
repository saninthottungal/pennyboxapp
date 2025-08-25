import 'package:drift/drift.dart';
import 'package:pennyboxapp/services/database/tables/accounts.table.dart';
import 'package:pennyboxapp/services/database/tables/transaction_types.table.dart';

@DataClassName('TransactionRaw', companion: 'TransactionRawCompanion')
class Transactions extends Table {
  late final id = integer()();
  late final description = text().nullable()();
  late final accountType = integer().references(
    Accounts,
    #id,
    onDelete: KeyAction.cascade,
  )();

  late final transactionType = integer().references(
    TransactionTypes,
    #id,
    onDelete: KeyAction.cascade,
  )();

  late final amount = real()();
  late final createdAt = dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
