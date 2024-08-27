import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeService {
  bool isDarkMode();
  void toggleTheme(bool isDarkMode);
  Future<void> loadThemePreference();
  Future<void> saveThemePreference(bool isDarkMode);
}

class ThemeServiceImpl implements ThemeService {
  static const String _themePrefKey = 'isDarkMode';
  bool _isDarkMode = false;

  ThemeServiceImpl() {
    loadThemePreference();
  }

  @override
  bool isDarkMode() => _isDarkMode;

  @override
  void toggleTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    saveThemePreference(isDarkMode);
  }

  @override
  Future<void> loadThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themePrefKey) ?? false;
  }

  @override
  Future<void> saveThemePreference(bool isDarkMode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefKey, isDarkMode);
  }
}
