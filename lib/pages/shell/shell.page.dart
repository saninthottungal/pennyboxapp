import 'package:flutter/material.dart';
import 'package:pennyboxapp/pages/home/home.page.dart';
import 'package:pennyboxapp/pages/profile/profile.page.dart';
import 'package:pennyboxapp/pages/transactions/transactions.page.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    TransactionsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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
