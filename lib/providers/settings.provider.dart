import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings.provider.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settings(Ref ref) {
  return SettingsRepository(SharedPreferencesAsync());
}

class SettingsRepository {
  SettingsRepository(this._sharedPref);

  static const isDarkModeKey = 'isDarkMode';

  final SharedPreferencesAsync _sharedPref;

  Future<ThemeMode> getThemeMode() async {
    final isDarkMode = (await _sharedPref.getBool(isDarkModeKey)) ?? false;

    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode mode) {
    final isDarkMode = mode == ThemeMode.dark;

    return _sharedPref.setBool(isDarkModeKey, isDarkMode);
  }

  Future<void> toggleTheme() async {
    final current = await getThemeMode();
    final mode = current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(mode);
  }
}
