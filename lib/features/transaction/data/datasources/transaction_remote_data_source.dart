import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yeu_tien/core/params/params.dart';
import 'package:yeu_tien/features/transaction/business/entities/transaction_entity.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransaction();

  Future<TransactionModel> postTransaction(
      {required TransactionParams transactionParams,
      required TransactionModel transactionModel});
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final response = await dio
        .get('https://660d4a076ddfa2943b33fbdf.mockapi.io/api/v1/transaction/');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = (response.data);
      return (jsonData).map((e) => TransactionModel.fromJson(json: e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TransactionModel> postTransaction(
      {required TransactionParams transactionParams,
      required TransactionModel transactionModel}) async {
    final response = await dio.post(
        'https://660d4a076ddfa2943b33fbdf.mockapi.io/api/v1/transaction/',
        data: transactionModel.toJson());

    if (response.statusCode == 200) {
      return TransactionModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }
  }
}
