import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/balance_entity.dart';
import '../../business/usecases/get_balance.dart';
import '../../data/datasources/balance_local_data_source.dart';
import '../../data/datasources/balance_remote_data_source.dart';
import '../../data/models/balance_model.dart';
import '../../data/repositories/balance_repository_impl.dart';

class BalanceProvider extends ChangeNotifier {
  BalanceEntity? balance;
  Failure? failure;

  BalanceProvider({
    this.balance,
    this.failure,
  });

  void eitherFailureOrBalance({
    required String value,
  }) async {
    BalanceRepositoryImpl repository = BalanceRepositoryImpl(
      remoteDataSource: BalanceRemoteDataSourceImpl(dio: Dio()),
      localDataSource: BalanceLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrBalance = await GetBalance(repository)
        .call(balanceParams: BalanceParams(id: value));

    failureOrBalance.fold(
      (Failure newFailure) {
        balance = null;
        failure = newFailure;
        notifyListeners();
      },
      (BalanceEntity newBalance) {
        balance = newBalance;
        failure = null;
        notifyListeners();
      },
    );
  }

  Future<void> updateBalance({
    required String id,
    required double newBalance,
  }) async {
    BalanceRepositoryImpl repository = BalanceRepositoryImpl(
      remoteDataSource: BalanceRemoteDataSourceImpl(dio: Dio()),
      localDataSource: BalanceLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrUpdatedBalance = await repository.putBalance(
      balanceParams: BalanceParams(id: id),
      balanceModel: BalanceModel(id: id, balance: newBalance),
    );

    failureOrUpdatedBalance.fold(
      (failure) {
        this.failure = failure;
        notifyListeners();
      },
      (updatedBalance) {
        balance = updatedBalance;
        failure = null;
        notifyListeners();
      },
    );
  }
}
