import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/theme/app_theme.dart';
import 'package:pennyboxapp/pages/shell/shell.page.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await AppDatabase().open();

  runApp(
    const ProviderScope(child: MyApp()),
  );

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ShadApp(
        theme: AppTheme.getThemeData(isDarkMode: false),
        darkTheme: AppTheme.getThemeData(isDarkMode: true),
        themeMode: ThemeMode.system,
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
