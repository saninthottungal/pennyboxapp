import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'transactions.logic.g.dart';

@riverpod
Stream<List<TransactionType>> transactionTypes(Ref ref) {
  final db = ref.watch(appDbpod);

  return db.transactionsDao.transactionTypesStream();
}

@riverpod
Stream<List<AccountType>> accountTypes(Ref ref) {
  final db = ref.watch(appDbpod);

  return db.transactionsDao.accountTypesStream();
}
