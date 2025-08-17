import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Transactions',
        style: context.textTheme.bodyLarge,
      ),
    );
  }
}
