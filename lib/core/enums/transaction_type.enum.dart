import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/constants/color_consts.dart';

enum TxnType {
  //! the id should not be changed at all.
  income(1),
  expense(2),
  transfer(3);

  final int id;

  String get asText => switch (this) {
    income => 'Income',
    expense => 'Expense',
    transfer => 'Transfer',
  };

  String get symbol => switch (this) {
    income => '+',
    expense => '-',
    transfer => '\u21C4',
  };

  String get actionLabel => switch (this) {
    income => 'Receiving from',
    expense => 'Paying to',
    transfer => 'Transferring to',
  };

  Color get color => switch (this) {
    income => AppColors.incomGreen,
    expense => AppColors.expenseRed,
    transfer => AppColors.transferBlue,
  };

  IconData get icon => switch (this) {
    income => Icons.arrow_downward,
    expense => Icons.arrow_upward,
    transfer => Icons.compare_arrows,
  };

  const TxnType(this.id);

  factory TxnType.fromMap(Map<String, Object?> map, [String? key]) {
    return TxnType.values.singleWhere((e) => e.id == map[key ?? 'id']);
  }
}
