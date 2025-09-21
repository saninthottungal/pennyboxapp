import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_with_balance.model.freezed.dart';
part 'account_with_balance.model.g.dart';

@freezed
abstract class AccountwBalance with _$AccountwBalance {
  const factory AccountwBalance({
    required int id,
    required String accountName,
    required double balance,
  }) = _AccountwBalance;

  factory AccountwBalance.fromJson(Map<String, Object?> json) =>
      _$AccountwBalanceFromJson(json);
}
