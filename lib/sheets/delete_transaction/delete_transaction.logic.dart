import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_transaction.logic.g.dart';

@riverpod
class DeleteTransaction extends _$DeleteTransaction {
  @override
  void build() {}

  Future<int> delete(int id) {
    return ref.read(appDbpod).transactionsDao.deleteTransaction(id);
  }
}
