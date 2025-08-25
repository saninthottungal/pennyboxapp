import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:path/path.dart';
import 'package:pennyboxapp/services/database/app_database.steps.dart';
import 'package:pennyboxapp/services/database/daos/transactions.dao.dart';
import 'package:pennyboxapp/services/database/tables/accounts.table.dart';
import 'package:pennyboxapp/services/database/tables/transaction_types.table.dart';
import 'package:pennyboxapp/services/database/tables/transactions.table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Accounts, TransactionTypes, Transactions],
  daos: [TransactionsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        await customStatement('PRAGMA foreign_keys = OFF');

        await transaction(() async {
          await m.runMigrationSteps(
            from: from,
            to: to,
            steps: migrationSteps(
              from1To2: (m, schema) async {
                await m.addColumn(
                  schema.transactions,
                  schema.transactions.description,
                );
              },
            ),
          );
        });

        if (kDebugMode) {
          // Fail if the migration broke foreign keys
          final wrongForeignKeys = await customSelect(
            'PRAGMA foreign_key_check',
          ).get();
          assert(
            wrongForeignKeys.isEmpty,
            '${wrongForeignKeys.map((e) => e.data)}',
          );
        }
        await customStatement('PRAGMA foreign_keys = ON');
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onCreate: (m) async {
        await m.createAll();

        await batch((batch) {
          batch.insert(
            accounts,
            AccountsCompanion.insert(name: 'Cash'),
          );

          batch.insertAll(
            transactionTypes,
            [
              TransactionTypesCompanion.insert(kind: 'Income'),
              TransactionTypesCompanion.insert(kind: 'Expense'),
              TransactionTypesCompanion.insert(kind: 'Transfer'),
            ],
          );
        });
      },
    );
  }

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await p.getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'pennyboxdb.sqlite'));
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

@Riverpod(keepAlive: true)
AppDatabase appDb(Ref ref) => AppDatabase();
