import 'package:pennyboxapp/providers/settings.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode.provider.g.dart';

@riverpod
class IsDarkTheme extends _$IsDarkTheme {
  @override
  bool build() {
    _updateFromSharedPref();
    return false;
  }

  Future<void> toggle(bool isDarkMode) async {
    state = isDarkMode;
    await ref.read(settingspod).toggleTheme(isDarkMode);
  }

  Future<void> _updateFromSharedPref() async {
    final isDarkMode = await ref.read(settingspod).getIsDarkTheme();
    state = isDarkMode;
  }
}
