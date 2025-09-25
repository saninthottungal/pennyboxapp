import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transactions.logic.g.dart';

@riverpod
Future<List<TxnType>> transactionTypes(Ref ref) {
  return AppDatabase().transactionDao.getTransactionTypes();
}

@riverpod
Future<List<Account>> getAccounts(Ref ref) {
  return AppDatabase().transactionDao.getAccounts();
}

@riverpod
class SelectedAccount extends _$SelectedAccount {
  @override
  Account? build() {
    final accounts = ref.watch(getAccountspod).value;

    return accounts?.firstOrNull;
  }

  void update(Account? account) {
    state = account;
  }
}

@riverpod
class SelectedTransactionType extends _$SelectedTransactionType {
  @override
  TxnType? build() {
    final types = ref.watch(transactionTypespod).value;

    return types?.firstOrNull;
  }

  void update(TxnType? account) {
    state = account;
  }
}

class TransactionsLogic extends ChangeNotifier {
  TransactionsLogic() {
    getHistory();
    getPlanned();
  }

  List<Transaction> history = [];
  List<Transaction> planned = [];

  Future<void> getHistory() async {
    final transactions = await AppDatabase().transactionDao.getTransactions();
    history = transactions;
    notifyListeners();
  }

  Future<void> getPlanned() async {
    final transactions = await AppDatabase().transactionDao.getTransactions(
      isPlanned: true,
    );
    planned = transactions;
    notifyListeners();
  }
}
