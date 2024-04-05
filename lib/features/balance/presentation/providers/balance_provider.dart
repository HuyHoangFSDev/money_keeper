import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeu_tien/features/transaction/data/models/transaction_model.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../../../core/errors/exceptions.dart';
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

  Future<void> eitherFailureOrBalance({
    required String value,
  }) async {
    final repository = BalanceRepositoryImpl(
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

  Future<void> calculateBalance({required String id}) async {
    try {
      final dio = Dio();
      final response = await dio.get(
          'https://660d4a076ddfa2943b33fbdf.mockapi.io/api/v1/transaction/');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = (response.data);
        final transactions =
        jsonData.map((e) => TransactionModel.fromJson(json: e)).toList();
        double newBalance = transactions.fold(0, (prev, transaction) {
          if (transaction.type == 'income') {
            return prev + transaction.amount;
          } else {
            return prev - transaction.amount;
          }
        });
        updateBalance(id: "1", newBalance: newBalance);
        notifyListeners();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> updateBalance({
    required String id,
    required double newBalance,
  }) async {
    try {
      final repository = BalanceRepositoryImpl(
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
    } catch (e) {
      throw ServerException();
    }
  }
}
