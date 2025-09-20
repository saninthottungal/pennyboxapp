import 'package:freezed_annotation/freezed_annotation.dart';

part 'party.model.g.dart';
part 'party.model.freezed.dart';

@freezed
abstract class Party with _$Party {
  const factory Party({
    required int id,
    required String name,
  }) = _Party;

  factory Party.fromJson(Map<String, Object?> json) => _$PartyFromJson(json);
}
