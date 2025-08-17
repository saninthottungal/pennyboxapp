import 'package:drift/drift.dart';

mixin EnumTableMixin on Table {
  late final id = integer().autoIncrement()();
  late final kind = text().unique()();
}
