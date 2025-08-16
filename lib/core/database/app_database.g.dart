// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class AccountTypes extends Table with TableInfo<AccountTypes, AccountType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AccountTypes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE NOT NULL',
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
  AccountTypes createAlias(String alias) {
    return AccountTypes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
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

class TransactionTypes extends Table
    with TableInfo<TransactionTypes, TransactionType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TransactionTypes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'UNIQUE NOT NULL',
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
  TransactionTypes createAlias(String alias) {
    return TransactionTypes(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final AccountTypes accountTypes = AccountTypes(this);
  late final TransactionTypes transactionTypes = TransactionTypes(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accountTypes,
    transactionTypes,
  ];
}

typedef $AccountTypesCreateCompanionBuilder =
    AccountTypesCompanion Function({Value<int> id, required String kind});
typedef $AccountTypesUpdateCompanionBuilder =
    AccountTypesCompanion Function({Value<int> id, Value<String> kind});

class $AccountTypesFilterComposer
    extends Composer<_$AppDatabase, AccountTypes> {
  $AccountTypesFilterComposer({
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
}

class $AccountTypesOrderingComposer
    extends Composer<_$AppDatabase, AccountTypes> {
  $AccountTypesOrderingComposer({
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

class $AccountTypesAnnotationComposer
    extends Composer<_$AppDatabase, AccountTypes> {
  $AccountTypesAnnotationComposer({
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
}

class $AccountTypesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          AccountTypes,
          AccountType,
          $AccountTypesFilterComposer,
          $AccountTypesOrderingComposer,
          $AccountTypesAnnotationComposer,
          $AccountTypesCreateCompanionBuilder,
          $AccountTypesUpdateCompanionBuilder,
          (
            AccountType,
            BaseReferences<_$AppDatabase, AccountTypes, AccountType>,
          ),
          AccountType,
          PrefetchHooks Function()
        > {
  $AccountTypesTableManager(_$AppDatabase db, AccountTypes table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $AccountTypesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $AccountTypesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $AccountTypesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
              }) => AccountTypesCompanion(id: id, kind: kind),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String kind}) =>
                  AccountTypesCompanion.insert(id: id, kind: kind),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $AccountTypesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      AccountTypes,
      AccountType,
      $AccountTypesFilterComposer,
      $AccountTypesOrderingComposer,
      $AccountTypesAnnotationComposer,
      $AccountTypesCreateCompanionBuilder,
      $AccountTypesUpdateCompanionBuilder,
      (AccountType, BaseReferences<_$AppDatabase, AccountTypes, AccountType>),
      AccountType,
      PrefetchHooks Function()
    >;
typedef $TransactionTypesCreateCompanionBuilder =
    TransactionTypesCompanion Function({Value<int> id, required String kind});
typedef $TransactionTypesUpdateCompanionBuilder =
    TransactionTypesCompanion Function({Value<int> id, Value<String> kind});

class $TransactionTypesFilterComposer
    extends Composer<_$AppDatabase, TransactionTypes> {
  $TransactionTypesFilterComposer({
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
}

class $TransactionTypesOrderingComposer
    extends Composer<_$AppDatabase, TransactionTypes> {
  $TransactionTypesOrderingComposer({
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

class $TransactionTypesAnnotationComposer
    extends Composer<_$AppDatabase, TransactionTypes> {
  $TransactionTypesAnnotationComposer({
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
}

class $TransactionTypesTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          TransactionTypes,
          TransactionType,
          $TransactionTypesFilterComposer,
          $TransactionTypesOrderingComposer,
          $TransactionTypesAnnotationComposer,
          $TransactionTypesCreateCompanionBuilder,
          $TransactionTypesUpdateCompanionBuilder,
          (
            TransactionType,
            BaseReferences<_$AppDatabase, TransactionTypes, TransactionType>,
          ),
          TransactionType,
          PrefetchHooks Function()
        > {
  $TransactionTypesTableManager(_$AppDatabase db, TransactionTypes table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TransactionTypesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TransactionTypesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TransactionTypesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
              }) => TransactionTypesCompanion(id: id, kind: kind),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String kind}) =>
                  TransactionTypesCompanion.insert(id: id, kind: kind),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TransactionTypesProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      TransactionTypes,
      TransactionType,
      $TransactionTypesFilterComposer,
      $TransactionTypesOrderingComposer,
      $TransactionTypesAnnotationComposer,
      $TransactionTypesCreateCompanionBuilder,
      $TransactionTypesUpdateCompanionBuilder,
      (
        TransactionType,
        BaseReferences<_$AppDatabase, TransactionTypes, TransactionType>,
      ),
      TransactionType,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $AccountTypesTableManager get accountTypes =>
      $AccountTypesTableManager(_db, _db.accountTypes);
  $TransactionTypesTableManager get transactionTypes =>
      $TransactionTypesTableManager(_db, _db.transactionTypes);
}
