import 'package:drift/drift.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/services/database/tables/mixins/enum_table.mixin.dart';

@DataClassName('TransactionTypeRaw', companion: 'TransactionTypeRawCompanion')
class TransactionTypes extends Table with EnumTableMixin {}

extension TransactionTypeRawX on TransactionTypeRaw {
  TxnType get asType {
    return TxnType.values.singleWhere((e) => e.id == id);
  }
}
