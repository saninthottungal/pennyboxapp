import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart';
import 'package:pennyboxapp/services/event_bus/event_bus.dart';

class TransactionsLogic extends ChangeNotifier {
  TransactionsLogic() {
    _dao = AppDatabase().transactionDao;

    getHistory();
    getPlanned();

    _event = eventBus.on<FetchTransactions>().listen(
      (e) => e.planned ? getPlanned() : getHistory(),
    );
  }

  late final TransactionDao _dao;
  StreamSubscription<FetchTransactions>? _event;

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

  Future<void> delete({
    required int? id,
    required String? transferId,
  }) async {
    await _dao.deleteTransaction(
      id: id,
      transferId: transferId,
    );
    history.removeWhere(
      (e) => e.id == id.toString() || e.id == transferId,
    );
    planned.removeWhere(
      (e) => e.id == id.toString() || e.id == transferId,
    );

    notifyListeners();
    eventBus.fire(FetchAccountBalances());
  }

  @override
  void dispose() {
    _event?.cancel();
    super.dispose();
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
