class TransactionEntity {
  final int id;
  final int balanceID;
  final String group;
  final double amount;
  final String note;
  final String type;
  final DateTime addAt;

  const TransactionEntity({
    required this.balanceID,
    required this.id,
    required this.group,
    required this.amount,
    required this.note,
    required this.type,
    required this.addAt,
  });
}
