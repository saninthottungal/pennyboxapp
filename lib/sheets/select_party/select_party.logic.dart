import 'package:pennyboxapp/services/db/db.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_party.logic.g.dart';

@riverpod
class Parties extends _$Parties {
  String _search = '';

  @override
  Future<List<Party>> build() {
    return AppSqfliteDb().transactionDao.getParties(search: _search);
  }

  Future<void> addParty(String name) {
    return AppSqfliteDb().transactionDao.addParty(name);
  }

  Future<void> deleteParty(int id) {
    return AppSqfliteDb().transactionDao.deleteParty(id);
  }

  Future<void> searchParties(String search) async {
    _search = search;
    ref.invalidateSelf();
  }
}
