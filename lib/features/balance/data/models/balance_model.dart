import '../../../../../core/constants/constants.dart';
import '../../business/entities/balance_entity.dart';

class BalanceModel extends BalanceEntity {
  const BalanceModel({
    required super.id,
    required super.balance,
  });

  factory BalanceModel.fromJson({required Map<String, dynamic> json}) {
    return BalanceModel(
      id: json[kId],
      balance: json[kBalance].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kBalance: balance,
    };
  }

}
