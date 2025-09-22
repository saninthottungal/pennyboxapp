import 'package:flutter/cupertino.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';

class HomeAccounts extends ChangeNotifier {
  HomeAccounts() {
    getAccountBalances();
  }

  List<AccountwBalance> balances = [];
  bool isLoading = false;

  Future<void> getAccountBalances() async {
    isLoading = true;
    final res = await AppDatabase().transactionDao.getAccountBalances();
    balances = res;
    isLoading = false;

    notifyListeners();
  }
}
