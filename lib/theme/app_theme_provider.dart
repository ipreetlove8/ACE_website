import 'package:flutter/material.dart';

import 'app_theme_data.dart';

class AppThemeProvider extends ChangeNotifier {
  AppThemeMode currentThemeMode = AppThemeMode.Dark;
  ThemeData appThemeData = AppThemeData.dark;
  AppThemeProvider() {
    appThemeData = AppThemeData.dark;
  }

  void toggleTheme() {
    if (currentThemeMode == AppThemeMode.Light) {
      appThemeData = AppThemeData.dark;
      currentThemeMode = AppThemeMode.Dark;
    } else {
      appThemeData = AppThemeData.light;
      currentThemeMode = AppThemeMode.Light;
    }
    notifyListeners();
  }
}

enum AppThemeMode { Light, Dark }
