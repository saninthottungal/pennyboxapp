import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pennyboxapp/services/database/app_database.dart';

part 'transaction.model.freezed.dart';

@freezed
sealed class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required double amount,
    String? description,
    required AccountType account,
    required TransactionType transactionType,
    required DateTime createdAt,
  }) = _Transaction;
}
