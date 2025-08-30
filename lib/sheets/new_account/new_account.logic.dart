import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_account.logic.g.dart';

@riverpod
class NewAccount extends _$NewAccount {
  @override
  void build() {}

  Future<int> addAccount(String name) {
    return ref.read(appDbpod).transactionsDao.addAccount(name);
  }
}
