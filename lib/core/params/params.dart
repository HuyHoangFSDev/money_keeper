class NoParams {}

class BalanceParams {
  final String id;

  const BalanceParams({required this.id});
}

class TransactionParams {
  String id;

  TransactionParams(this.id);
}
