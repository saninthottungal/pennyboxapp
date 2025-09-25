import 'package:flutter/material.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart';
import 'package:pennyboxapp/services/event_bus/event_bus.dart';

class TransactionsLogic extends ChangeNotifier {
  TransactionsLogic() {
    _dao = AppDatabase().transactionDao;
  }

  late final TransactionDao _dao;

  List<Transaction> history = [];
  List<Transaction> planned = [];

  Future<void> getHistory() async {
    history = await _dao.getTransactions();
    notifyListeners();
  }

  Future<void> getPlanned() async {
    planned = await _dao.getTransactions(isPlanned: true);

    notifyListeners();
  }

  Future<void> delete(int id) async {
    await _dao.deleteTransaction(id);
    history.removeWhere((e) => e.id == id);
    planned.removeWhere((e) => e.id == id);

    notifyListeners();
    eventBus.fire(FetchAccountBalances());
  }
}

class TransactionsProvider extends InheritedWidget {
  TransactionsProvider({
    required super.child,
  }) : controller = TransactionsLogic();

  final TransactionsLogic controller;

  static TransactionsLogic of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TransactionsProvider>()!
        .controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
