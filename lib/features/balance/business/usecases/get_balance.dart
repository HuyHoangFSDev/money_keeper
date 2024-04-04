import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/balance_entity.dart';
import '../repositories/balance_repository.dart';

class GetBalance {
  final BalanceRepository balanceRepository;

  GetBalance(this.balanceRepository);

  Future<Either<Failure, BalanceEntity>> call({
    required BalanceParams balanceParams,
  }) async {
    return await balanceRepository.getBalance(balanceParams: balanceParams);
  }
}
