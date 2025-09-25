import 'package:flutter/material.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart';

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
}
