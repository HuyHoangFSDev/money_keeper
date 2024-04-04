import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<void> cacheTransaction({required List<TransactionModel> transactionToCache});
  Future<List<TransactionModel>> getLastTransaction();
}

const cachedTransaction = 'CACHED_TRANSACTION';

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final SharedPreferences sharedPreferences;

  TransactionLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TransactionModel>> getLastTransaction() {
    final jsonString = sharedPreferences.getString(cachedTransaction);

    if (jsonString != null) {
      final jsonList = json.decode(jsonString) as List;
      return Future.value(jsonList.map((json) => TransactionModel.fromJson(json: json)).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTransaction({required List<TransactionModel> transactionToCache}) async {
    if (transactionToCache.isNotEmpty) {
      final jsonList = transactionToCache.map((transaction) => transaction.toJson()).toList();
      sharedPreferences.setString(
        cachedTransaction,
        json.encode(jsonList),
      );
    } else {
      throw CacheException();
    }
  }
}