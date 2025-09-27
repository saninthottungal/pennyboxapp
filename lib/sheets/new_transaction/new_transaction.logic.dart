import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';
import 'package:pennyboxapp/services/event_bus/event_bus.dart';

class NewTransactionLogic extends ChangeNotifier {
  NewTransactionLogic() {
    _dao = AppDatabase().transactionDao;
    updateOptionsWithLastTnx();
  }

  late final TransactionDao _dao;

  Future<void> updateOptionsWithLastTnx() async {
    final tnx = (await _dao.getTransactions(limit: 2)).firstOrNull;
    selectedAccount = tnx?.account;
    selectedTxnType = tnx?.type;
    notifyListeners();
  }

  String amount = '';

  void append(String char) {
    if (char == '.' && amount.contains('.')) return;

    amount = '$amount$char';
    notifyListeners();
  }

  void clear() {
    amount = '';
    notifyListeners();
  }

  void backSpace() {
    if (amount.isEmpty) return;
    amount = amount.substring(0, amount.length - 1);
    notifyListeners();
  }

  List<TxnType> transactionTypes = [];

  Future<void> getTrancationTypes() async {
    transactionTypes = await _dao.getTransactionTypes();
    notifyListeners();
  }

  Party? selectedParty;

  void updateParty(Party party) {
    selectedParty = party;
    notifyListeners();
  }

  TxnType? selectedTxnType;

  void updateSelectedTransactionType(TxnType? account) {
    selectedTxnType = account;
    selectedParty = null;
    transferringTo = null;
    notifyListeners();
  }

  Account? selectedAccount;

  void updateSelectedAccount(Account? account) {
    selectedAccount = account;
    notifyListeners();
  }

  Account? transferringTo;

  void updateTransferringTo(Account account) {
    transferringTo = account;
    notifyListeners();
  }

  List<Account> accounts = [];

  Future<void> getAccounts() async {
    accounts = await _dao.getAccounts();
    notifyListeners();
  }

  Future<bool> addTransaction({
    required DateTime transactionAt,
    required String? description,
  }) async {
    if (selectedAccount == null ||
        selectedTxnType == null ||
        double.tryParse(amount) == null ||
        selectedParty == null ||
        double.tryParse(amount) == 0) {
      return false;
    }

    await AppDatabase().transactionDao.addTransaction(
      amount: double.parse(amount),
      accountId: selectedAccount!.id,
      transactionTypeId: selectedTxnType!.id,
      transactionAt: transactionAt,
      partyId: selectedParty!.id,
      description: description,
    );

    eventBus
      ..fire(FetchAccountBalances())
      ..fire(
        FetchTransactions(
          planned: transactionAt.isAfter(DateTime.now()),
        ),
      );

    return true;
  }
}
