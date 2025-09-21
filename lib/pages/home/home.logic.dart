import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home.logic.g.dart';

@riverpod
Future<List<AccountwBalance>> getAccountBalances(Ref ref) async {
  final res = await AppDatabase().transactionDao.getAccountBalances();
  return res;
}
