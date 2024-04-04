import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/transaction_entity.dart';
import '../../business/usecases/get_transaction.dart';
import '../../data/datasources/transaction_local_data_source.dart';
import '../../data/datasources/transaction_remote_data_source.dart';
import '../../data/repositories/transaction_repository_impl.dart';


class TransactionProvider extends ChangeNotifier {
  List<TransactionEntity>? transaction;
  Failure? failure;

  TransactionProvider({
    this.transaction,
    this.failure,
  });

  void eitherFailureOrTransaction({
    required String value,
  }) async {
    TransactionRepositoryImpl repository = TransactionRepositoryImpl(
      remoteDataSource: TransactionRemoteDataSourceImpl(dio: Dio()),
      localDataSource: TransactionLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrTransaction = await GetTransaction(repository)
        .call(transactionParams: TransactionParams());

    failureOrTransaction.fold(
      (Failure newFailure) {
        transaction = null;
        failure = newFailure;
        notifyListeners();
      },
      (List<TransactionEntity> newTransaction) {
        transaction = newTransaction;
        failure = null;
        notifyListeners();
      },
    );
  }
}
