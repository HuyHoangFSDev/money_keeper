import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/balance_model.dart';

abstract class BalanceRemoteDataSource {
  Future<BalanceModel> getBalance({required BalanceParams balanceParams});
  Future<BalanceModel> putBalance({required BalanceParams balanceParams, required BalanceModel balanceModel});
}

class BalanceRemoteDataSourceImpl implements BalanceRemoteDataSource {
  final Dio dio;

  BalanceRemoteDataSourceImpl({required this.dio});

  @override
  Future<BalanceModel> getBalance({required BalanceParams balanceParams}) async {
    final response = await dio.get(
      'https://660d4a076ddfa2943b33fbdf.mockapi.io/api/v1/balance/${balanceParams.id}/',
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response.statusCode == 200) {
      return BalanceModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BalanceModel> putBalance({required BalanceParams balanceParams, required BalanceModel balanceModel}) async {
    final response = await dio.put(
      'https://660d4a076ddfa2943b33fbdf.mockapi.io/api/v1/balance/${balanceParams.id}/',
      data: balanceModel.toJson(),
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response.statusCode == 200) {
      return BalanceModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
