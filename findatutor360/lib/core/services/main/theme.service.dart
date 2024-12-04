import 'package:findatutor360/utils/shared_pref.dart';

// Abstract class defining the contract for the Theme Service
abstract class ThemeService {
  // Returns whether the current theme is dark mode
  bool isDarkMode();

  // Toggles the theme and updates the preference
  void toggleTheme(bool isDarkMode);

  // Loads the theme preference from storage
  Future<void> loadThemePreference();

  // Saves the theme preference to storage
  Future<void> saveThemePreference(bool isDarkMode);
}

// Implementation of the Theme Service
class ThemeServiceImpl implements ThemeService {
  static const String _themePrefKey =
      'isDarkMode'; // Key for storing theme preference
  bool _isDarkMode = false; // Holds the current theme state
  final appPreferences =
      AppPreferences(); // Shared preferences utility for persistent storage

  // Constructor initializes the theme preference by loading it from storage
  ThemeServiceImpl() {
    loadThemePreference();
  }

  // Returns the current theme state (dark mode or light mode)
  @override
  bool isDarkMode() => _isDarkMode;

  // Updates the theme state and saves the new preference to storage
  @override
  void toggleTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode; // Update the local state
    saveThemePreference(isDarkMode); // Persist the new state
  }

  // Loads the theme preference from storage
  @override
  Future<void> loadThemePreference() async {
    // Fetch the preference using the key; defaults to `false` if not set
    _isDarkMode = await appPreferences.getBool(_themePrefKey);
  }

  // Saves the theme preference to storage
  @override
  Future<void> saveThemePreference(bool isDarkMode) async {
    await appPreferences.setBool(
        _themePrefKey, isDarkMode); // Save the preference using the key
  }
}
