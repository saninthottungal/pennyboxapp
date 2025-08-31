import 'package:drift/drift.dart';

@DataClassName('Party', companion: 'PartyCompanion')
class Parties extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
}
