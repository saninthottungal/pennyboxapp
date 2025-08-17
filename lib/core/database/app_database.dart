import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:path/path.dart';
import 'package:pennyboxapp/core/database/app_database.steps.dart';
import 'package:pennyboxapp/core/database/tables/account_types.table.dart';
import 'package:pennyboxapp/core/database/tables/transaction_types.table.dart';
import 'package:pennyboxapp/core/database/tables/transactions.table.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [AccountTypes, TransactionTypes, Transactions],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.addColumn(
            schema.transactions,
            schema.transactions.description,
          );
        },
      ),
    );
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await p.getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      // Also work around limitations on old Android versions

      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      // Make sqlite3 pick a more suitable location for temporary files - the
      // one from the system may be inaccessible due to sandboxing.
      final cachebase = (await p.getTemporaryDirectory()).path;
      // We can't access /tmp on Android, which sqlite3 would try by default.
      // Explicitly tell it about the correct temporary directory.
      sqlite3.tempDirectory = cachebase;
      return NativeDatabase.createInBackground(file);
    });
  }
}
