import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_party.logic.g.dart';

@riverpod
class Parties extends _$Parties {
  @override
  Stream<List<Party>> build() {
    final db = ref.watch(appDbpod);
    return db.transactionsDao.getParties();
  }

  Future<int> addParty(String name) {
    return ref.read(appDbpod).transactionsDao.addParty(name);
  }

  Future<int> deleteParty(int id) {
    return ref.read(appDbpod).transactionsDao.deleteParty(id);
  }
}
