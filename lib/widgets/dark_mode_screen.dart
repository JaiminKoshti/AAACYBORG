import 'package:flutter/material.dart';

class DarkModeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

/*  Color get textColor {
    return _isDarkMode ? Colors.white : Colors.black;
  }

  Color get lightTextColor {
    // Customize the light color here
    return Colors.green;
  }*/


  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

