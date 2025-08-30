import 'package:intl/intl.dart';
import 'package:pennyboxapp/core/constants/currency_consts.dart';

extension DoubleExtension on num {
  String toMoney() {
    final formatter = NumberFormat.currency(
      symbol: AppCurrency.current,
      decimalDigits: this % 1 == 0 ? 0 : 2,
    );
    return formatter.format(this);
  }
}
