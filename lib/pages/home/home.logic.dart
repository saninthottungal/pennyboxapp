import 'package:flutter/cupertino.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';

class AccountsLogic extends ChangeNotifier {
  AccountsLogic() {
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

  Future<void> addAccount(String name) async {
    await AppDatabase().transactionDao.addAccount(name);
    getAccountBalances();
  }

  Future<void> deleteAccount(int id) async {
    await AppDatabase().transactionDao.deleteAccount(id);
    getAccountBalances();
  }
}
