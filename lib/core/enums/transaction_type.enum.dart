enum TransactionType {
  income(1),
  expense(2),
  transfer(3);

  final int id;
  const TransactionType(this.id);
}
