import 'package:pennyboxapp/services/db/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account.logic.g.dart';

@riverpod
class DeleteAccount extends _$DeleteAccount {
  @override
  void build() {}

  Future<void> delete(int id) {
    return AppDatabase().transactionDao.deleteAccount(id);
  }
}
