import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:path/path.dart';

part 'app_database.g.dart';

@DriftDatabase(
  include: {
    'tables/transactions.table.drift',
    'tables/transaction_type.table.drift',
    'tables/account_type.table.drift',
  },
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await p.getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));

      return NativeDatabase.createInBackground(file);
    });
  }
}
