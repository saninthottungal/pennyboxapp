import 'package:event_bus/event_bus.dart';

final eventBus = EventBus();

class FetchAccountBalances {}

class FetchTransactions {
  FetchTransactions({required this.planned});
  final bool planned;
}
