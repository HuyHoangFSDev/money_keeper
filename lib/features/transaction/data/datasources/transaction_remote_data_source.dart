import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransaction(
      {required TransactionParams transactionParams});
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TransactionModel>> getTransaction(
      {required TransactionParams transactionParams}) async {
    final response = await dio.get(
      'https://660d4a076ddfa2943b33fbdf.mockapi.io/api/v1/transaction',
      queryParameters: {
        'api_key': 'if needed',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.data)
          .map((e) => TransactionModel.fromJson(json: e));
    } else {
      throw ServerException();
    }
  }
}
