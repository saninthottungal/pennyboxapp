import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_with_balance.model.freezed.dart';

@freezed
abstract class AccountwBalance with _$AccountwBalance {
  const factory AccountwBalance({
    required int id,
    required String accountName,
    required double balance,
  }) = _AccountwBalance;
}
