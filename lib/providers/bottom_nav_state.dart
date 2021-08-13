import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 1;

  get currentIndex => _currentIndex;

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
