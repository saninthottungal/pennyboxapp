import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'new_transaction.logic.g.dart';

@riverpod
class NewTransactionAmount extends _$NewTransactionAmount {
  @override
  String build() => '';

  void append(String char) {
    state = '$state$char';
  }

  void clear() => state = '';

  void backSpace() {
    if (state.isEmpty) return;
    state = state.substring(0, state.length - 1);
  }
}
