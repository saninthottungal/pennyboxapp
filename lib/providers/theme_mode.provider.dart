import 'package:flutter/material.dart';
import 'package:pennyboxapp/providers/settings.provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode.provider.g.dart';

@riverpod
class ThemeModeLogic extends _$ThemeModeLogic {
  @override
  ThemeMode build() {
    updateTheme();
    return ThemeMode.light;
  }

  Future<void> toggle() {
    return ref.read(settingspod).toggleTheme();
  }

  Future<void> updateTheme() async {
    final theme = await ref.read(settingspod).getThemeMode();
    state = theme;
  }
}
