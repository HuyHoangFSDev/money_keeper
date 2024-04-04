import 'package:dartz/dartz.dart';
import 'package:yeu_tien/features/balance/data/models/balance_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/balance_entity.dart';

abstract class BalanceRepository {
  Future<Either<Failure, BalanceEntity>> getBalance({
    required BalanceParams balanceParams,
  });

  Future<Either<Failure, BalanceEntity>> putBalance({
    required BalanceParams balanceParams,
    required BalanceModel balanceModel,
  });
}
