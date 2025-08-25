import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/services/database/models/transaction.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'transactions.logic.g.dart';

@riverpod
Future<List<TransactionType>> transactionTypes(Ref ref) {
  final db = ref.watch(appDbpod);

  return db.transactionsDao.geTransactionTypes();
}

@riverpod
Future<List<Account>> getAccounts(Ref ref) {
  final db = ref.watch(appDbpod);

  return db.transactionsDao.getAccounts();
}

@riverpod
class SelectedAccount extends _$SelectedAccount {
  @override
  Account? build() {
    final transactions = ref.watch(transactionspod).value;

    return transactions?.firstOrNull?.account;
  }

  void update(Account? account) {
    state = account;
  }
}

@riverpod
class SelectedTransactionType extends _$SelectedTransactionType {
  @override
  TransactionType? build() {
    final transactions = ref.watch(transactionspod).value;

    return transactions?.firstOrNull?.transactionType;
  }

  void update(TransactionType? account) {
    state = account;
  }
}

@riverpod
Stream<List<Transaction>> transactions(Ref ref) {
  final db = ref.watch(appDbpod);
  return db.transactionsDao.transactionsStream();
}
