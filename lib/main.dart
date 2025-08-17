import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/theme/app_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      theme: AppTheme.themeData,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<String> _pages = [
    "Income",
    "Expense",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _pages[_currentIndex],
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              _currentIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              _currentIndex == 1
                  ? Icons.receipt_rounded
                  : Icons.receipt_outlined,
            ),
            label: "Transactions",
          ),
          NavigationDestination(
            icon: Icon(
              _currentIndex == 2 ? Icons.person : Icons.person_outline,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
