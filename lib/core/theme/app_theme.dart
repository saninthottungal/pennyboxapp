import 'dart:ui';

import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  const AppTheme._();

  static ShadThemeData get themeData {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: const ShadNeutralColorScheme.dark(),
    );
  }
}
