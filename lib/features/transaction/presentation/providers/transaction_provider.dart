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
import '../../data/models/transaction_model.dart';
import '../../data/repositories/transaction_repository_impl.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionEntity>? transaction;
  Failure? failure;

  TransactionProvider({
    this.transaction,
    this.failure,
  });

  Future<void> eitherFailureOrTransaction() async {
    TransactionRepositoryImpl repository = TransactionRepositoryImpl(
      remoteDataSource: TransactionRemoteDataSourceImpl(dio: Dio()),
      localDataSource: TransactionLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrTransaction = await GetTransaction(repository).call();

    failureOrTransaction.fold(
          (newFailure) {
        transaction = null;
        failure = newFailure;
        notifyListeners();
      },
          (newTransaction) {
        transaction = newTransaction;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future<void> postTransaction({
    required String id,
    required String balanceID,
    required String group,
    required double amount,
    required String note,
    required String type,
    required String addAt,
  }) async {
    TransactionRepositoryImpl repository = TransactionRepositoryImpl(
      remoteDataSource: TransactionRemoteDataSourceImpl(dio: Dio()),
      localDataSource: TransactionLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrUpdatedTransaction = await repository.postTransaction(
      transactionParams: TransactionParams(id),
      transactionModel: TransactionModel(
        id: id,
        balanceID: balanceID,
        group: group,
        amount: amount,
        note: note,
        type: type,
        addAt: addAt,
      ),
    );

    failureOrUpdatedTransaction.fold(
          (failure) {
        this.failure = failure;
        notifyListeners();
      },
          (updatedTransaction) {
        transaction = [updatedTransaction];
        failure = null;
        notifyListeners();
      },
    );
  }
}
