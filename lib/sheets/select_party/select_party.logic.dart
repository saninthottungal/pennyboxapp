import 'package:flutter/material.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';

class SelectPartyLogic extends ChangeNotifier {
  SelectPartyLogic() {
    _dao = AppDatabase().transactionDao;
    getParties();
  }
  late final TransactionDao _dao;

  List<Party> parties = [];

  Future<void> getParties({String search = ''}) async {
    parties = await _dao.getParties(search: search);
    notifyListeners();
  }

  Future<void> addParty(String name) async {
    await _dao.addParty(name);
    return getParties();
  }

  Future<void> deleteParty(int id) async {
    await _dao.deleteParty(id);
    return getParties();
  }

  Future<void> searchParties(String search) {
    return getParties(search: search);
  }
}
