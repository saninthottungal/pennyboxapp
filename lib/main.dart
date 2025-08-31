import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/theme/app_theme.dart';
import 'package:pennyboxapp/pages/shell/shell.page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ShadApp(
        themeMode: ThemeMode.light,
        theme: AppTheme.getThemeData(isDarkMode: true),
        home: Builder(
          builder: (context) {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: const ShellPage(),
            );
          },
        ),
      ),
    );
  }
}
