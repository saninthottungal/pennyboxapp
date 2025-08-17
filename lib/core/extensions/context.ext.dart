import 'package:flutter/material.dart';

extension ContextEXT on BuildContext {
  // Theme-related
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  /// equirevilent to [MediaQuery.sizeOf(context)]
  Size get mdSize => MediaQuery.sizeOf(this);
  EdgeInsets get mdPadding => MediaQuery.paddingOf(this);
}
