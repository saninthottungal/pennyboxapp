// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountTypesTable extends AccountTypes
    with TableInfo<$AccountTypesTable, AccountType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, kind];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
    );
  }

  @override
  $AccountTypesTable createAlias(String alias) {
    return $AccountTypesTable(attachedDatabase, alias);
  }
}

class AccountType extends DataClass implements Insertable<AccountType> {
  final int id;
  final String kind;
  const AccountType({required this.id, required this.kind});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kind'] = Variable<String>(kind);
    return map;
  }

  AccountTypesCompanion toCompanion(bool nullToAbsent) {
    return AccountTypesCompanion(id: Value(id), kind: Value(kind));
  }

  factory AccountType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountType(
      id: serializer.fromJson<int>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(kind),
    };
  }

  AccountType copyWith({int? id, String? kind}) =>
      AccountType(id: id ?? this.id, kind: kind ?? this.kind);
  AccountType copyWithCompanion(AccountTypesCompanion data) {
    return AccountType(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountType(')
          ..write('id: $id, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kind);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountType && other.id == this.id && other.kind == this.kind);
}

class AccountTypesCompanion extends UpdateCompanion<AccountType> {
  final Value<int> id;
  final Value<String> kind;
  const AccountTypesCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
  });
  AccountTypesCompanion.insert({
    this.id = const Value.absent(),
    required String kind,
  }) : kind = Value(kind);
  static Insertable<AccountType> custom({
    Expression<int>? id,
    Expression<String>? kind,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
    });
  }

  AccountTypesCompanion copyWith({Value<int>? id, Value<String>? kind}) {
    return AccountTypesCompanion(id: id ?? this.id, kind: kind ?? this.kind);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountTypesCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }
}

class $TransactionTypesTable extends TransactionTypes
    with TableInfo<$TransactionTypesTable, TransactionType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, kind];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
    );
  }

  @override
  $TransactionTypesTable createAlias(String alias) {
    return $TransactionTypesTable(attachedDatabase, alias);
  }
}

class TransactionType extends DataClass implements Insertable<TransactionType> {
  final int id;
  final String kind;
  const TransactionType({required this.id, required this.kind});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kind'] = Variable<String>(kind);
    return map;
  }

  TransactionTypesCompanion toCompanion(bool nullToAbsent) {
    return TransactionTypesCompanion(id: Value(id), kind: Value(kind));
  }

  factory TransactionType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionType(
      id: serializer.fromJson<int>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(kind),
    };
  }

  TransactionType copyWith({int? id, String? kind}) =>
      TransactionType(id: id ?? this.id, kind: kind ?? this.kind);
  TransactionType copyWithCompanion(TransactionTypesCompanion data) {
    return TransactionType(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionType(')
          ..write('id: $id, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kind);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionType &&
          other.id == this.id &&
          other.kind == this.kind);
}

class TransactionTypesCompanion extends UpdateCompanion<TransactionType> {
  final Value<int> id;
  final Value<String> kind;
  const TransactionTypesCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
  });
  TransactionTypesCompanion.insert({
    this.id = const Value.absent(),
    required String kind,
  }) : kind = Value(kind);
  static Insertable<TransactionType> custom({
    Expression<int>? id,
    Expression<String>? kind,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
    });
  }

  TransactionTypesCompanion copyWith({Value<int>? id, Value<String>? kind}) {
    return TransactionTypesCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTypesCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accountTypeMeta = const VerificationMeta(
    'accountType',
  );
  @override
  late final GeneratedColumn<int> accountType = GeneratedColumn<int>(
    'account_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES account_types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<int> transactionType = GeneratedColumn<int>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transaction_types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountType,
    transactionType,
    amount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_type')) {
      context.handle(
        _accountTypeMeta,
        accountType.isAcceptableOrUnknown(
          data['account_type']!,
          _accountTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountTypeMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_type'],
      )!,
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int accountType;
  final int transactionType;
  final double amount;
  final DateTime createdAt;
  const Transaction({
    required this.id,
    required this.accountType,
    required this.transactionType,
    required this.amount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_type'] = Variable<int>(accountType);
    map['transaction_type'] = Variable<int>(transactionType);
    map['amount'] = Variable<double>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      accountType: Value(accountType),
      transactionType: Value(transactionType),
      amount: Value(amount),
      createdAt: Value(createdAt),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      accountType: serializer.fromJson<int>(json['accountType']),
      transactionType: serializer.fromJson<int>(json['transactionType']),
      amount: serializer.fromJson<double>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountType': serializer.toJson<int>(accountType),
      'transactionType': serializer.toJson<int>(transactionType),
      'amount': serializer.toJson<double>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Transaction copyWith({
    int? id,
    int? accountType,
    int? transactionType,
    double? amount,
    DateTime? createdAt,
  }) => Transaction(
    id: id ?? this.id,
    accountType: accountType ?? this.accountType,
    transactionType: transactionType ?? this.transactionType,
    amount: amount ?? this.amount,
    createdAt: createdAt ?? this.createdAt,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      accountType: data.accountType.present
          ? data.accountType.value
          : this.accountType,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('accountType: $accountType, ')
          ..write('transactionType: $transactionType, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, accountType, transactionType, amount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.accountType == this.accountType &&
          other.transactionType == this.transactionType &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> accountType;
  final Value<int> transactionType;
  final Value<double> amount;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.accountType = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int accountType,
    required int transactionType,
    required double amount,
    this.createdAt = const Value.absent(),
  }) : accountType = Value(accountType),
       transactionType = Value(transactionType),
       amount = Value(amount);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? accountType,
    Expression<int>? transactionType,
    Expression<double>? amount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountType != null) 'account_type': accountType,
      if (transactionType != null) 'transaction_type': transactionType,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountType,
    Value<int>? transactionType,
    Value<double>? amount,
    Value<DateTime>? createdAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      transactionType: transactionType ?? this.transactionType,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<int>(accountType.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<int>(transactionType.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountType: $accountType, ')
          ..write('transactionType: $transactionType, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountTypesTable accountTypes = $AccountTypesTable(this);
  late final $TransactionTypesTable transactionTypes = $TransactionTypesTable(
    this,
  );
  late final $TransactionsTable transactions = $TransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accountTypes,
    transactionTypes,
    transactions,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'account_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transaction_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AccountTypesTableCreateCompanionBuilder =
    AccountTypesCompanion Function({Value<int> id, required String kind});
typedef $$AccountTypesTableUpdateCompanionBuilder =
    AccountTypesCompanion Function({Value<int> id, Value<String> kind});

final class $$AccountTypesTableReferences
    extends BaseReferences<_$AppDatabase, $AccountTypesTable, AccountType> {
  $$AccountTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(
      db.accountTypes.id,
      db.transactions.accountType,
    ),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.accountType.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountTypesTableFilterComposer
    extends Composer<_$AppDatabase, $AccountTypesTable> {
  $$AccountTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountType,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountTypesTable> {
  $$AccountTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountTypesTable> {
  $$AccountTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.accountType,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountTypesTable,
          AccountType,
          $$AccountTypesTableFilterComposer,
          $$AccountTypesTableOrderingComposer,
          $$AccountTypesTableAnnotationComposer,
          $$AccountTypesTableCreateCompanionBuilder,
          $$AccountTypesTableUpdateCompanionBuilder,
          (AccountType, $$AccountTypesTableReferences),
          AccountType,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$AccountTypesTableTableManager(_$AppDatabase db, $AccountTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
              }) => AccountTypesCompanion(id: id, kind: kind),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String kind}) =>
                  AccountTypesCompanion.insert(id: id, kind: kind),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      AccountType,
                      $AccountTypesTable,
                      Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$AccountTypesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AccountTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.accountType == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AccountTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountTypesTable,
      AccountType,
      $$AccountTypesTableFilterComposer,
      $$AccountTypesTableOrderingComposer,
      $$AccountTypesTableAnnotationComposer,
      $$AccountTypesTableCreateCompanionBuilder,
      $$AccountTypesTableUpdateCompanionBuilder,
      (AccountType, $$AccountTypesTableReferences),
      AccountType,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionTypesTableCreateCompanionBuilder =
    TransactionTypesCompanion Function({Value<int> id, required String kind});
typedef $$TransactionTypesTableUpdateCompanionBuilder =
    TransactionTypesCompanion Function({Value<int> id, Value<String> kind});

final class $$TransactionTypesTableReferences
    extends
        BaseReferences<_$AppDatabase, $TransactionTypesTable, TransactionType> {
  $$TransactionTypesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(
      db.transactionTypes.id,
      db.transactions.transactionType,
    ),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.transactionType.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionTypesTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionTypesTable> {
  $$TransactionTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.transactionType,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionTypesTable> {
  $$TransactionTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionTypesTable> {
  $$TransactionTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.transactionType,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransactionTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionTypesTable,
          TransactionType,
          $$TransactionTypesTableFilterComposer,
          $$TransactionTypesTableOrderingComposer,
          $$TransactionTypesTableAnnotationComposer,
          $$TransactionTypesTableCreateCompanionBuilder,
          $$TransactionTypesTableUpdateCompanionBuilder,
          (TransactionType, $$TransactionTypesTableReferences),
          TransactionType,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$TransactionTypesTableTableManager(
    _$AppDatabase db,
    $TransactionTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
              }) => TransactionTypesCompanion(id: id, kind: kind),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String kind}) =>
                  TransactionTypesCompanion.insert(id: id, kind: kind),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      TransactionType,
                      $TransactionTypesTable,
                      Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$TransactionTypesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TransactionTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.transactionType == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TransactionTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionTypesTable,
      TransactionType,
      $$TransactionTypesTableFilterComposer,
      $$TransactionTypesTableOrderingComposer,
      $$TransactionTypesTableAnnotationComposer,
      $$TransactionTypesTableCreateCompanionBuilder,
      $$TransactionTypesTableUpdateCompanionBuilder,
      (TransactionType, $$TransactionTypesTableReferences),
      TransactionType,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required int accountType,
      required int transactionType,
      required double amount,
      Value<DateTime> createdAt,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int> accountType,
      Value<int> transactionType,
      Value<double> amount,
      Value<DateTime> createdAt,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountTypesTable _accountTypeTable(_$AppDatabase db) =>
      db.accountTypes.createAlias(
        $_aliasNameGenerator(db.transactions.accountType, db.accountTypes.id),
      );

  $$AccountTypesTableProcessedTableManager get accountType {
    final $_column = $_itemColumn<int>('account_type')!;

    final manager = $$AccountTypesTableTableManager(
      $_db,
      $_db.accountTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountTypeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TransactionTypesTable _transactionTypeTable(_$AppDatabase db) =>
      db.transactionTypes.createAlias(
        $_aliasNameGenerator(
          db.transactions.transactionType,
          db.transactionTypes.id,
        ),
      );

  $$TransactionTypesTableProcessedTableManager get transactionType {
    final $_column = $_itemColumn<int>('transaction_type')!;

    final manager = $$TransactionTypesTableTableManager(
      $_db,
      $_db.transactionTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionTypeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountTypesTableFilterComposer get accountType {
    final $$AccountTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountType,
      referencedTable: $db.accountTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountTypesTableFilterComposer(
            $db: $db,
            $table: $db.accountTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionTypesTableFilterComposer get transactionType {
    final $$TransactionTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionType,
      referencedTable: $db.transactionTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionTypesTableFilterComposer(
            $db: $db,
            $table: $db.transactionTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountTypesTableOrderingComposer get accountType {
    final $$AccountTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountType,
      referencedTable: $db.accountTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountTypesTableOrderingComposer(
            $db: $db,
            $table: $db.accountTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionTypesTableOrderingComposer get transactionType {
    final $$TransactionTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionType,
      referencedTable: $db.transactionTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionTypesTableOrderingComposer(
            $db: $db,
            $table: $db.transactionTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountTypesTableAnnotationComposer get accountType {
    final $$AccountTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountType,
      referencedTable: $db.accountTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.accountTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TransactionTypesTableAnnotationComposer get transactionType {
    final $$TransactionTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionType,
      referencedTable: $db.transactionTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.transactionTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({bool accountType, bool transactionType})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountType = const Value.absent(),
                Value<int> transactionType = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                accountType: accountType,
                transactionType: transactionType,
                amount: amount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountType,
                required int transactionType,
                required double amount,
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                accountType: accountType,
                transactionType: transactionType,
                amount: amount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountType = false, transactionType = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountType) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountType,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._accountTypeTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._accountTypeTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (transactionType) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.transactionType,
                                    referencedTable:
                                        $$TransactionsTableReferences
                                            ._transactionTypeTable(db),
                                    referencedColumn:
                                        $$TransactionsTableReferences
                                            ._transactionTypeTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({bool accountType, bool transactionType})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountTypesTableTableManager get accountTypes =>
      $$AccountTypesTableTableManager(_db, _db.accountTypes);
  $$TransactionTypesTableTableManager get transactionTypes =>
      $$TransactionTypesTableTableManager(_db, _db.transactionTypes);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
}
