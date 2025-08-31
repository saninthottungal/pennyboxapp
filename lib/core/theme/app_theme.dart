import 'dart:ui';

import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  const AppTheme._();

  static ShadThemeData getThemeData({required bool isDarkMode}) {
    return ShadThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,

      // Available Options:
      // ShadGrayColorScheme
      // ShadGreenColorScheme
      // ShadNeutralColorScheme
      // ShadOrangeColorScheme
      // ShadRedColorScheme
      // ShadRoseColorScheme
      // ShadSlateColorScheme
      // ShadStoneColorScheme
      // ShadVioletColorScheme
      // ShadYellowColorScheme
      // ShadZincColorScheme
      colorScheme: isDarkMode
          ? const ShadNeutralColorScheme.dark()
          : const ShadNeutralColorScheme.light(),
    );
  }
}
