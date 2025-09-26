class DbMigrations {
  DbMigrations._();

  static const _v1 = [
    //* Accounts Table
    '''
        CREATE TABLE IF NOT EXISTS accounts
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
        );
        ''',

    //* Transaction Types Table
    '''
        CREATE TABLE IF NOT EXISTS transaction_types
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kind TEXT UNIQUE NOT NULL
        );
        ''',

    //* Parties Table
    '''
        CREATE TABLE IF NOT EXISTS parties
        (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
        );
        ''',

    //* Transactions Table
    '''
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
        ''',

    //* Insert default values
    'INSERT INTO accounts (name) values ("Cash");',
    '''
        INSERT INTO transaction_types (kind) VALUES 
        ("Income"),
        ("Expense"),
        ("Transfer");
        ''',
  ];

  static const _v2 = [
    '''
ALTER TABLE transactions ADD COLUMN transferred_to INTEGER;
''',
  ];
  static const Map<int, List<String>> queries = {
    1: _v1,
    2: _v2,
  };
}
