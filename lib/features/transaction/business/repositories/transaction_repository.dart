import 'package:dartz/dartz.dart';
import 'package:yeu_tien/features/transaction/data/models/transaction_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getTransaction();
  Future<Either<Failure, TransactionEntity>> postTransaction({
    required TransactionParams transactionParams,
    required TransactionModel transactionModel
});
}
