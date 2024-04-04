import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/balance_model.dart';

abstract class BalanceLocalDataSource {
  Future<void> cacheBalance({required BalanceModel? balanceToCache});
  Future<BalanceModel> getLastBalance();
}

const cachedBalance = 'CACHED_BALANCE';

class BalanceLocalDataSourceImpl implements BalanceLocalDataSource {
  final SharedPreferences sharedPreferences;

  BalanceLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<BalanceModel> getLastBalance() {
    final jsonString = sharedPreferences.getString(cachedBalance);

    if (jsonString != null) {
      return Future.value(BalanceModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBalance({required BalanceModel? balanceToCache}) async {
    if (balanceToCache != null) {
      sharedPreferences.setString(
        cachedBalance,
        json.encode(
          balanceToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
