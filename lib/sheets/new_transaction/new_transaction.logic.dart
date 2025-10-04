import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart';
import 'package:pennyboxapp/services/event_bus/event_bus.dart';

class NewTransactionLogic extends ChangeNotifier {
  NewTransactionLogic() {
    _dao = AppDb().transactionDao;
    updateOptionsWithLastTnx();
  }

  late final TnxDao _dao;

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
        (selectedParty == null && transferringTo == null) ||
        double.tryParse(amount) == null ||
        selectedAccount?.id == transferringTo?.id) {
      return false;
    }

    if (selectedTxnType!.isTransfer) {
      await _dao.addTransferTransaction(
        amount: double.parse(amount),
        fromAccountId: selectedAccount!.id,
        toAccountId: transferringTo!.id,
        transactionAt: transactionAt,
        description: description,
      );
    } else {
      await _dao.addTransaction(
        amount: double.parse(amount),
        accountId: selectedAccount!.id,
        transactionTypeId: selectedTxnType!.id,
        transactionAt: transactionAt,
        partyId: selectedParty?.id,
        description: description,
        transferId: null,
      );
    }

    eventBus
      ..fire(FetchAccountBalances())
      ..fire(
        FetchTransactions(
          planned: transactionAt.isAfter(DateTime.now()),
        ),
      );

    return true;
  }

  DateTime? transactionAt;

  Future<Transaction?> getSingleTransaction(String id) async {
    final idNumber = int.tryParse(id);
    final tnx = await _dao.getSingleTransaction(idNumber ?? id);
    if (tnx == null) throw Exception("Transaction not found");

    selectedAccount = tnx.account;
    selectedTxnType = tnx.type;
    selectedParty = tnx.party;
    amount = tnx.amount.toString();
    transactionAt = tnx.transactionAt;
    return tnx;
  }

  Future<bool> editTransaction(
    String id, {
    required DateTime transactionAt,
    required String? description,
  }) async {
    if (selectedAccount == null ||
        selectedTxnType == null ||
        double.tryParse(amount) == null ||
        (selectedParty == null && transferringTo == null) ||
        double.tryParse(amount) == null ||
        selectedAccount?.id == transferringTo?.id) {
      return false;
    }
    final isSuccess = await _dao.editTransaction(
      id,
      amount: DbValue(double.parse(amount)),
      accountId: DbValue(selectedAccount?.id),
      description: DbValue(description),
      partyId: DbValue(selectedParty?.id),
      transactionAt: DbValue(transactionAt),
      transactionTypeId: DbValue(selectedTxnType?.id),
      transferId: DbValue(transferringTo?.id),
    );

    eventBus
      ..fire(FetchAccountBalances())
      ..fire(
        FetchTransactions(
          planned: transactionAt.isAfter(DateTime.now()),
        ),
      );

    return isSuccess;
  }
}
