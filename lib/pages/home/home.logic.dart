import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/services/database/models/account_with_balance.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home.logic.g.dart';

@riverpod
Stream<List<AccountwBalance>> getAccountBalances(Ref ref) {
  final db = ref.watch(appDbpod);

  return db.transactionsDao.getAccountBalances();
}
