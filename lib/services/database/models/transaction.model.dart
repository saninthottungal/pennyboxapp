import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/database/app_database.dart';

part 'transaction.model.freezed.dart';

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required double amount,
    String? description,
    required Account account,
    required TxnType type,
    required DateTime transactionAt,
    required Party? party,
  }) = _Transaction;
}
