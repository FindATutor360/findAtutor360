import 'package:findatutor360/core/services/main/theme.service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:flutter/material.dart';

class ThemeController extends BaseProvider {
  final ThemeServiceImpl themeServiceImpl;
  bool _isDarkMode = false;

  ThemeController(this.themeServiceImpl) {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    themeServiceImpl.toggleTheme(_isDarkMode);
    notifyListeners();
  }

  void _loadThemePreference() async {
    await themeServiceImpl.loadThemePreference();
    _isDarkMode = themeServiceImpl.isDarkMode();
    notifyListeners();
  }
}
