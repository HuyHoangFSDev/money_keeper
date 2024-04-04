import 'package:flutter/material.dart';

class SelectedBalanceProvider extends ChangeNotifier {
  int number;

  SelectedBalanceProvider({this.number = 0});

  void changeBalance({required int newBalance}) {
    number = newBalance;
    notifyListeners();
  }
}
