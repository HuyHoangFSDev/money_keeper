import '../../../../../core/constants/constants.dart';
import '../../business/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.balanceID,
    required super.id,
    required super.group,
    required super.amount,
    required super.note,
    required super.type,
    required super.addAt,
  });

  factory TransactionModel.fromJson({required Map<String, dynamic> json}) {
    return TransactionModel(
      balanceID: json[kId],
      id: json[kId],
      group: json[kGroup],
      amount: json[kAmount].toDouble(),
      note: json[kNote],
      type: json[kType],
      addAt: json[kAddAt]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kBalanceId: balanceID,
      kGroup: group,
      kAmount: amount,
      kNote: note,
      kType: type,
      kAddAt: addAt
    };
  }
}
