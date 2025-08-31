import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account.logic.g.dart';

@riverpod
class DeleteAccount extends _$DeleteAccount {
  @override
  void build() {}

  Future<void> delete(int id) {
    return ref.read(appDbpod).transactionsDao.deleteAccount(id);
  }
}
