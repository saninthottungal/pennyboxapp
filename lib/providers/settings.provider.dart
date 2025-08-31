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

  Future<bool> getIsDarkTheme() async {
    final isDarkMode = (await _sharedPref.getBool(isDarkModeKey)) ?? false;
    return isDarkMode;
  }

  Future<void> setThemeMode(bool isDarkMode) {
    return _sharedPref.setBool(isDarkModeKey, isDarkMode);
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    await setThemeMode(isDarkMode);
  }
}
