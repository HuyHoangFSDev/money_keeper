import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransaction {
  final TransactionRepository transactionRepository;

  GetTransaction(this.transactionRepository);

  Future<Either<Failure, List<TransactionEntity>>> call({
    required TransactionParams transactionParams,
  }) async {
    return await transactionRepository.getTransaction(
        transactionParams: transactionParams);
  }
}
