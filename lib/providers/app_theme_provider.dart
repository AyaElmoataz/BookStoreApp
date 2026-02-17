import 'package:book_store_app/services/theme_local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider = AsyncNotifierProvider<AppThemeNotifier, ThemeMode>(
  AppThemeNotifier.new,
);

class AppThemeNotifier extends AsyncNotifier<ThemeMode> {
  final service = ThemeLocalStorageService();

  @override
  Future<ThemeMode> build() async {
    return await service.getTheme();
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = AsyncData(mode);
    await service.saveTheme(mode);
  }
}
