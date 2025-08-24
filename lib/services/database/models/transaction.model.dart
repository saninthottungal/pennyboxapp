import 'package:pennyboxapp/services/database/app_database.dart';

class Transaction {
  Transaction({
    required this.id,
    required this.amount,
    required this.account,
    required this.transactionType,
    required this.createdAt,
    required this.description,
  });

  final int id;
  final double amount;
  final String? description;
  final AccountType account;
  final TransactionType transactionType;
  final DateTime createdAt;
}
