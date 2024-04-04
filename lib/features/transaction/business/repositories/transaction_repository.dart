import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/transaction_entity.dart';


abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransaction({
    required TransactionParams transactionParams,
  });
}
