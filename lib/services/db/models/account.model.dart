import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.model.g.dart';
part 'account.model.freezed.dart';

@freezed
abstract class Account with _$Account {
  const factory Account({
    required int id,
    required String name,
  }) = _Account;

  factory Account.fromJson(Map<String, Object?> json) =>
      _$AccountFromJson(json);
}
