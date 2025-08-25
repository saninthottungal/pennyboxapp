import 'package:drift/drift.dart';

class Accounts extends Table {
  late final id = integer().autoIncrement()();
  late final name = text().unique()();
}
