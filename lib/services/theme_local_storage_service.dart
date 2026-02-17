import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalStorageService {
  static const _themeKey = 'theme_mode';

  Future<void> saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeKey);

    if (value == null) {
      return ThemeMode.light;
    }

    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.light,
    );
  }
}
