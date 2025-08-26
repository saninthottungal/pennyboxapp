enum TransactionType {
  income(1, 'Income'),
  expense(2, 'Expense'),
  transfer(3, 'Transfer');

  final int id;
  final String asText;

  const TransactionType(this.id, this.asText);
}
