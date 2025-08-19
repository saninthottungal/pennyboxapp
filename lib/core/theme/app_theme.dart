import 'dart:ui';

import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  const AppTheme._();

  static ShadThemeData get themeData {
    return ShadThemeData(
      brightness: Brightness.dark,

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
      colorScheme: const ShadNeutralColorScheme.dark(),
    );
  }
}
