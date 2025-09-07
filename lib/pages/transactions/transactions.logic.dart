import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/services/database/models/transaction.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions.logic.g.dart';

@riverpod
Future<List<TxnType>> transactionTypes(Ref ref) {
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
    final transactions = ref.watch(getTransactionspod).value;
    final accounts = ref.watch(getAccountspod).value;

    return transactions?.firstOrNull?.account ?? accounts?.firstOrNull;
  }

  void update(Account? account) {
    state = account;
  }
}

@riverpod
class SelectedTransactionType extends _$SelectedTransactionType {
  @override
  TxnType? build() {
    final transactions = ref.watch(getTransactionspod).value;
    final types = ref.watch(transactionTypespod).value;

    return transactions?.firstOrNull?.type ?? types?.firstOrNull;
  }

  void update(TxnType? account) {
    state = account;
  }
}

@riverpod
Stream<List<Transaction>> getTransactions(Ref ref) {
  final db = ref.watch(appDbpod);
  return db.transactionsDao.transactionsStream();
}

final hasPlannedTransactionsPod = StreamProvider.autoDispose<int>((ref) {
  final dao = ref.watch(appDbpod).transactionsDao;
  return dao.hasPlannedTransactionsStream();
});
