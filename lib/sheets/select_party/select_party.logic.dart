import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_party.logic.g.dart';

@riverpod
Stream<List<Party>> getParties(Ref ref) {
  final db = ref.watch(appDbpod);
  return db.transactionsDao.getParties();
}
