import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pennyboxapp/core/theme/app_theme.dart';
import 'package:pennyboxapp/pages/home/home.logic.dart';
import 'package:pennyboxapp/pages/shell/shell.page.dart';
import 'package:pennyboxapp/pages/transactions/transactions.logic.dart';
import 'package:pennyboxapp/services/db/db.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await AppDatabase().open();

  runApp(
    AccountsProvider(
      controller: AccountsLogic(AppDatabase().transactionDao),
      child: TransactionsProvider(
        child: const MyApp(),
      ),
    ),
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
