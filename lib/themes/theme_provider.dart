import 'package:flutter/material.dart';
import 'package:newssile/themes/dark_mode.dart';
import 'package:newssile/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Initially The light mode
  ThemeData _themeData = lightMode;
  //get theme
  ThemeData get themeData => _themeData;
  //isDark Mode
  bool get isDarkMode => _themeData == darkMode;
  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    //to update UI
    notifyListeners();
  }

  //toggle Theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
