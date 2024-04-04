import 'package:flutter/material.dart';

class SelectedGroupProvider extends ChangeNotifier {
  int selectedGroup;

  SelectedGroupProvider({
    this.selectedGroup = 0,
  });

  void changeGroup(int newValue) {
    selectedGroup = newValue;
    notifyListeners();
  }
}
