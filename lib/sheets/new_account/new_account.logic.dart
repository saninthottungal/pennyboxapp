import 'package:pennyboxapp/services/db/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_account.logic.g.dart';

@riverpod
class NewAccount extends _$NewAccount {
  @override
  void build() {}

  Future<void> addAccount(String name) {
    return AppDatabase().transactionDao.addAccount(name);
  }
}
