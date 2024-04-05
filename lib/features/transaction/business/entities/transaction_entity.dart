class TransactionEntity {
  final String id;
  final String balanceID;
  final String group;
  final double amount;
  final String note;
  final String type;
  final String addAt;

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
