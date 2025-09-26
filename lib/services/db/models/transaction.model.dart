import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';

part 'transaction.model.freezed.dart';
part 'transaction.model.g.dart';

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required double amount,
    String? description,
    required Account account,
    required TxnType type,
    required DateTime transactionAt,
    Party? party,
    Account? transferredTo,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, Object?> json) =>
      _$TransactionFromJson(json);
}
