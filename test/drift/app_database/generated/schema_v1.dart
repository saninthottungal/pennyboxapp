// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class AccountTypes extends Table
    with TableInfo<AccountTypes, AccountTypesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AccountTypes(this.attachedDatabase, [this._alias]);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountTypesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountTypesData(
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
  AccountTypes createAlias(String alias) {
    return AccountTypes(attachedDatabase, alias);
  }
}

class AccountTypesData extends DataClass
    implements Insertable<AccountTypesData> {
  final int id;
  final String kind;
  const AccountTypesData({required this.id, required this.kind});
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

  factory AccountTypesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountTypesData(
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

  AccountTypesData copyWith({int? id, String? kind}) =>
      AccountTypesData(id: id ?? this.id, kind: kind ?? this.kind);
  AccountTypesData copyWithCompanion(AccountTypesCompanion data) {
    return AccountTypesData(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountTypesData(')
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
      (other is AccountTypesData &&
          other.id == this.id &&
          other.kind == this.kind);
}

class AccountTypesCompanion extends UpdateCompanion<AccountTypesData> {
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
  static Insertable<AccountTypesData> custom({
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

class TransactionTypes extends Table
    with TableInfo<TransactionTypes, TransactionTypesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TransactionTypes(this.attachedDatabase, [this._alias]);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionTypesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionTypesData(
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
  TransactionTypes createAlias(String alias) {
    return TransactionTypes(attachedDatabase, alias);
  }
}

class TransactionTypesData extends DataClass
    implements Insertable<TransactionTypesData> {
  final int id;
  final String kind;
  const TransactionTypesData({required this.id, required this.kind});
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

  factory TransactionTypesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionTypesData(
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

  TransactionTypesData copyWith({int? id, String? kind}) =>
      TransactionTypesData(id: id ?? this.id, kind: kind ?? this.kind);
  TransactionTypesData copyWithCompanion(TransactionTypesCompanion data) {
    return TransactionTypesData(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTypesData(')
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
      (other is TransactionTypesData &&
          other.id == this.id &&
          other.kind == this.kind);
}

class TransactionTypesCompanion extends UpdateCompanion<TransactionTypesData> {
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
  static Insertable<TransactionTypesData> custom({
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

class Transactions extends Table
    with TableInfo<Transactions, TransactionsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Transactions(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
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
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsData(
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
  Transactions createAlias(String alias) {
    return Transactions(attachedDatabase, alias);
  }
}

class TransactionsData extends DataClass
    implements Insertable<TransactionsData> {
  final int id;
  final int accountType;
  final int transactionType;
  final double amount;
  final DateTime createdAt;
  const TransactionsData({
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

  factory TransactionsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsData(
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

  TransactionsData copyWith({
    int? id,
    int? accountType,
    int? transactionType,
    double? amount,
    DateTime? createdAt,
  }) => TransactionsData(
    id: id ?? this.id,
    accountType: accountType ?? this.accountType,
    transactionType: transactionType ?? this.transactionType,
    amount: amount ?? this.amount,
    createdAt: createdAt ?? this.createdAt,
  );
  TransactionsData copyWithCompanion(TransactionsCompanion data) {
    return TransactionsData(
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
    return (StringBuffer('TransactionsData(')
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
      (other is TransactionsData &&
          other.id == this.id &&
          other.accountType == this.accountType &&
          other.transactionType == this.transactionType &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionsData> {
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
  static Insertable<TransactionsData> custom({
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

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final AccountTypes accountTypes = AccountTypes(this);
  late final TransactionTypes transactionTypes = TransactionTypes(this);
  late final Transactions transactions = Transactions(this);
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
  int get schemaVersion => 1;
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
