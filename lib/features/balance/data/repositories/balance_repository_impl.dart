import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/balance_repository.dart';
import '../datasources/balance_local_data_source.dart';
import '../datasources/balance_remote_data_source.dart';
import '../models/balance_model.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BalanceRemoteDataSource remoteDataSource;
  final BalanceLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BalanceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, BalanceModel>> getBalance(
      {required BalanceParams balanceParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        BalanceModel remoteBalance =
            await remoteDataSource.getBalance(balanceParams: balanceParams);

        localDataSource.cacheBalance(balanceToCache: remoteBalance);

        return Right(remoteBalance);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      try {
        BalanceModel localBalance = await localDataSource.getLastBalance();
        return Right(localBalance);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }

  @override
  Future<Either<Failure, BalanceModel>> putBalance({
    required BalanceParams balanceParams,
    required BalanceModel balanceModel,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final updatedBalance = await remoteDataSource.putBalance(
          balanceParams: balanceParams,
          balanceModel: balanceModel,
        );
        localDataSource.cacheBalance(balanceToCache: updatedBalance);
        return Right(updatedBalance);
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
