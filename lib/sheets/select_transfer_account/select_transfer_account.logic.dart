import 'package:flutter/material.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';

class SelectTransferLogic extends ChangeNotifier {
  SelectTransferLogic() {
    _dao = AppDb().transactionDao;
    getAccounts();
  }

  late final TnxDao _dao;
  List<Account> accounts = [];

  Future<void> getAccounts() async {
    accounts = await _dao.getAccounts();
    notifyListeners();
  }
}
