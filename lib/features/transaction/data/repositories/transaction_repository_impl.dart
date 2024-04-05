import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';
import '../datasources/transaction_remote_data_source.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransaction() async {
    if (await networkInfo.isConnected!) {
      try {
        List<TransactionModel> remoteTransaction =
            await remoteDataSource.getTransaction();

        localDataSource.cacheTransaction(transactionToCache: remoteTransaction);

        return Right(remoteTransaction);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        List<TransactionModel> localTransaction = await localDataSource.getLastTransaction();
        return Right(localTransaction);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }

  @override
  Future<Either<Failure, TransactionModel>> postTransaction({
    required TransactionParams transactionParams,
    required TransactionModel transactionModel,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final updatedTransaction = await remoteDataSource.postTransaction(
          transactionParams: transactionParams,
          transactionModel: transactionModel,
        );
        return Right(updatedTransaction);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(
        NetworkFailure(errorMessage: 'No internet connection available'),
      );
    }
  }
}
