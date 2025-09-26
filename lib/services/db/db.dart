import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pennyboxapp/services/db/daos/transactions.dao.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  factory AppDatabase() {
    return _instance;
  }

  AppDatabase._();

  static final _instance = AppDatabase._();

  late final Database _db;
  Database get db => _db;

  late final TransactionDao transactionDao;

  Future<Database> open() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final String path = join(dbFolder.path, 'pennyboxdb.sqlite');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        final batch = db.batch();

        //* Accounts Table
        batch.execute('''
        CREATE TABLE IF NOT EXISTS accounts
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
        );
        ''');

        //* Transaction Types Table
        batch.execute('''
        CREATE TABLE IF NOT EXISTS transaction_types
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kind TEXT UNIQUE NOT NULL
        );
        ''');

        //* Parties Table
        batch.execute('''
        CREATE TABLE IF NOT EXISTS parties
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
        );
        ''');

        //* Transactions Table
        batch.execute('''
        CREATE TABLE IF NOT EXISTS transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        amount REAL CHECK (amount > 0),
        created_at TEXT NOT NULL  DEFAULT CURRENT_TIMESTAMP,
        transaction_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        account_id INTEGER NOT NULL REFERENCES accounts(id) ON DELETE CASCADE ON UPDATE CASCADE,
        transaction_type_id INTEGER NOT NULL REFERENCES transaction_types(id) ON DELETE CASCADE ON UPDATE CASCADE,
        party_id INTEGER  REFERENCES parties(id)  ON DELETE SET NULL ON UPDATE SET NULL
        );
        ''');

        //* Insert default values
        batch.rawInsert('INSERT INTO accounts (name) values ("Cash");');
        batch.rawInsert('''
        INSERT INTO transaction_types (kind) VALUES 
        ("Income"),
        ("Expense"),
        ("Transfer");
        ''');

        await batch.commit(noResult: true);
      },
    );

    transactionDao = TransactionDao(_db);
    return _db;
  }
}
