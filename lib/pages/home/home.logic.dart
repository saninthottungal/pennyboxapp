import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';
import 'package:pennyboxapp/services/event_bus/event_bus.dart';

class AccountsLogic extends ChangeNotifier {
  AccountsLogic() {
    _dao = AppDatabase().transactionDao;
    getAccountBalances();
    _eventSub = eventBus.on<FetchAccountBalances>().listen(
      (_) => getAccountBalances(),
    );
  }

  late final TransactionDao _dao;
  StreamSubscription<FetchAccountBalances>? _eventSub;

  List<AccountwBalance> balances = [];
  bool isLoading = false;

  Future<void> getAccountBalances() async {
    isLoading = true;
    final res = await _dao.getAccountBalances();
    balances = res;
    isLoading = false;

    notifyListeners();
  }

  Future<void> addAccount(String name) async {
    await _dao.addAccount(name);
    getAccountBalances();
  }

  Future<void> deleteAccount(int id) async {
    await _dao.deleteAccount(id);
    getAccountBalances();
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    super.dispose();
  }
}

class AccountsProvider extends InheritedWidget {
  AccountsProvider({
    required super.child,
  }) : controller = AccountsLogic();

  final AccountsLogic controller;

  static AccountsLogic of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AccountsProvider>()!
        .controller;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
