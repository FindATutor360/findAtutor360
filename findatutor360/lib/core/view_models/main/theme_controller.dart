import 'package:findatutor360/core/services/main/theme.service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:flutter/material.dart';

/// Controller for managing the theme preference (dark mode or light mode).
/// Inherits from [BaseProvider] to notify listeners of changes in the theme.
class ThemeController extends BaseProvider {
  // Instance of the ThemeServiceImpl class used to manage theme preferences.
  final ThemeServiceImpl themeServiceImpl;

  // Private variable to hold the current theme state (dark or light).
  bool _isDarkMode = false;

  // Constructor that accepts an instance of ThemeServiceImpl and loads the theme preference.
  ThemeController(this.themeServiceImpl) {
    _loadThemePreference(); // Load the theme preference when the controller is instantiated.
  }

  // Public getter to access the current theme state (dark or light).
  bool get isDarkMode => _isDarkMode;

  // Public getter to determine the current theme mode for the app (either dark or light).
  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Toggles between dark mode and light mode.
  /// Calls the ThemeServiceImpl to save the theme preference and notifies listeners of the change.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // Toggle the theme mode.
    themeServiceImpl.toggleTheme(
        _isDarkMode); // Update the theme preference in the service.
    notifyListeners(); // Notify listeners to update the UI with the new theme.
  }

  /// Loads the user's theme preference from the service and updates the controller state.
  /// This is typically called during initialization.
  void _loadThemePreference() async {
    await themeServiceImpl
        .loadThemePreference(); // Fetch saved theme preference from the service.
    _isDarkMode = themeServiceImpl
        .isDarkMode(); // Update the _isDarkMode state based on the service.
    notifyListeners(); // Notify listeners to update the UI with the loaded theme.
  }
}
