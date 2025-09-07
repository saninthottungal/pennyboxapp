import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_transaction.logic.g.dart';

@riverpod
class NewTransactionAmount extends _$NewTransactionAmount {
  @override
  String build() => '';

  void append(String char) {
    if (char == '.' && state.contains('.')) return;

    state = '$state$char';
  }

  void clear() => state = '';

  void backSpace() {
    if (state.isEmpty) return;
    state = state.substring(0, state.length - 1);
  }
}

@riverpod
class SelectedParty extends _$SelectedParty {
  @override
  Party? build() {
    return null;
  }

  void update(Party party) {
    state = party;
  }
}
