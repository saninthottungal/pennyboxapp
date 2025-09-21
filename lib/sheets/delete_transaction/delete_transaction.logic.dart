import 'package:pennyboxapp/services/db/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_transaction.logic.g.dart';

@riverpod
class DeleteTransaction extends _$DeleteTransaction {
  @override
  void build() {}

  Future<void> delete(int id) {
    return AppSqfliteDb().transactionDao.deleteTransaction(id);
  }
}
