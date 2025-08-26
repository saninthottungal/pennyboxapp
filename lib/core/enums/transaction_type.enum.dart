import 'dart:ui';

import 'package:pennyboxapp/core/constants/color_consts.dart';

enum TxnType {
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

  Color get color => switch (this) {
    income => AppColors.incomGreen,
    expense => AppColors.expenseRed,
    transfer => AppColors.transferBlue,
  };

  const TxnType(this.id);
}
