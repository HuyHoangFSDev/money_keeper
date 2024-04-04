import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedCurrencyProvider extends ChangeNotifier {
  late String selectedCurrencySymbol;

  SelectedCurrencyProvider() {
    selectedCurrencySymbol = "";
    loadSelectedCurrency();
  }

  Future<void> loadSelectedCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedCurrencySymbol = prefs.getString('symbolCurrency') ?? '';
    notifyListeners();
  }

  void changeCurrency(String newValue) {
    selectedCurrencySymbol = newValue;
    notifyListeners();
  }
}
