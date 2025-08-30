// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Accounts extends Table with TableInfo<Accounts, AccountsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Accounts(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  Accounts createAlias(String alias) {
    return Accounts(attachedDatabase, alias);
  }
}

class AccountsData extends DataClass implements Insertable<AccountsData> {
  final int id;
  final String name;
  const AccountsData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(id: Value(id), name: Value(name));
  }

  factory AccountsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountsData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  AccountsData copyWith({int? id, String? name}) =>
      AccountsData(id: id ?? this.id, name: name ?? this.name);
  AccountsData copyWithCompanion(AccountsCompanion data) {
    return AccountsData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountsData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountsData && other.id == this.id && other.name == this.name);
}

class AccountsCompanion extends UpdateCompanion<AccountsData> {
  final Value<int> id;
  final Value<String> name;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<AccountsData> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  AccountsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return AccountsCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
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
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  late final GeneratedColumn<int> transactionTypeId = GeneratedColumn<int>(
    'transaction_type_id',
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
  late final GeneratedColumn<DateTime> transactionAt =
      GeneratedColumn<DateTime>(
        'transaction_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: const CustomExpression('CURRENT_TIMESTAMP'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    accountId,
    transactionTypeId,
    amount,
    createdAt,
    transactionAt,
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
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      transactionTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_type_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      transactionAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_at'],
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
  final String? description;
  final int accountId;
  final int transactionTypeId;
  final double amount;
  final DateTime createdAt;
  final DateTime transactionAt;
  const TransactionsData({
    required this.id,
    this.description,
    required this.accountId,
    required this.transactionTypeId,
    required this.amount,
    required this.createdAt,
    required this.transactionAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['account_id'] = Variable<int>(accountId);
    map['transaction_type_id'] = Variable<int>(transactionTypeId);
    map['amount'] = Variable<double>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['transaction_at'] = Variable<DateTime>(transactionAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      accountId: Value(accountId),
      transactionTypeId: Value(transactionTypeId),
      amount: Value(amount),
      createdAt: Value(createdAt),
      transactionAt: Value(transactionAt),
    );
  }

  factory TransactionsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsData(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      accountId: serializer.fromJson<int>(json['accountId']),
      transactionTypeId: serializer.fromJson<int>(json['transactionTypeId']),
      amount: serializer.fromJson<double>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      transactionAt: serializer.fromJson<DateTime>(json['transactionAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String?>(description),
      'accountId': serializer.toJson<int>(accountId),
      'transactionTypeId': serializer.toJson<int>(transactionTypeId),
      'amount': serializer.toJson<double>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'transactionAt': serializer.toJson<DateTime>(transactionAt),
    };
  }

  TransactionsData copyWith({
    int? id,
    Value<String?> description = const Value.absent(),
    int? accountId,
    int? transactionTypeId,
    double? amount,
    DateTime? createdAt,
    DateTime? transactionAt,
  }) => TransactionsData(
    id: id ?? this.id,
    description: description.present ? description.value : this.description,
    accountId: accountId ?? this.accountId,
    transactionTypeId: transactionTypeId ?? this.transactionTypeId,
    amount: amount ?? this.amount,
    createdAt: createdAt ?? this.createdAt,
    transactionAt: transactionAt ?? this.transactionAt,
  );
  TransactionsData copyWithCompanion(TransactionsCompanion data) {
    return TransactionsData(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      transactionTypeId: data.transactionTypeId.present
          ? data.transactionTypeId.value
          : this.transactionTypeId,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      transactionAt: data.transactionAt.present
          ? data.transactionAt.value
          : this.transactionAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsData(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('accountId: $accountId, ')
          ..write('transactionTypeId: $transactionTypeId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('transactionAt: $transactionAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    accountId,
    transactionTypeId,
    amount,
    createdAt,
    transactionAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsData &&
          other.id == this.id &&
          other.description == this.description &&
          other.accountId == this.accountId &&
          other.transactionTypeId == this.transactionTypeId &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt &&
          other.transactionAt == this.transactionAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionsData> {
  final Value<int> id;
  final Value<String?> description;
  final Value<int> accountId;
  final Value<int> transactionTypeId;
  final Value<double> amount;
  final Value<DateTime> createdAt;
  final Value<DateTime> transactionAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.accountId = const Value.absent(),
    this.transactionTypeId = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.transactionAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required int accountId,
    required int transactionTypeId,
    required double amount,
    this.createdAt = const Value.absent(),
    this.transactionAt = const Value.absent(),
  }) : accountId = Value(accountId),
       transactionTypeId = Value(transactionTypeId),
       amount = Value(amount);
  static Insertable<TransactionsData> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<int>? accountId,
    Expression<int>? transactionTypeId,
    Expression<double>? amount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? transactionAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (accountId != null) 'account_id': accountId,
      if (transactionTypeId != null) 'transaction_type_id': transactionTypeId,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
      if (transactionAt != null) 'transaction_at': transactionAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<String?>? description,
    Value<int>? accountId,
    Value<int>? transactionTypeId,
    Value<double>? amount,
    Value<DateTime>? createdAt,
    Value<DateTime>? transactionAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      accountId: accountId ?? this.accountId,
      transactionTypeId: transactionTypeId ?? this.transactionTypeId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      transactionAt: transactionAt ?? this.transactionAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (transactionTypeId.present) {
      map['transaction_type_id'] = Variable<int>(transactionTypeId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (transactionAt.present) {
      map['transaction_at'] = Variable<DateTime>(transactionAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('accountId: $accountId, ')
          ..write('transactionTypeId: $transactionTypeId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt, ')
          ..write('transactionAt: $transactionAt')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV3 extends GeneratedDatabase {
  DatabaseAtV3(QueryExecutor e) : super(e);
  late final Accounts accounts = Accounts(this);
  late final TransactionTypes transactionTypes = TransactionTypes(this);
  late final Transactions transactions = Transactions(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    transactionTypes,
    transactions,
  ];
  @override
  int get schemaVersion => 3;
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
