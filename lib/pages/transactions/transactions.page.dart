import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/constants/currency_consts.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:pennyboxapp/pages/new_transaction/new_transaction.page.dart';
import 'package:pennyboxapp/pages/transactions/transactions.logic.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConsts.bodyHorizPadding.copyWith(
        top: context.mdPadding.top,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.gutter,
        children: [
          /// Add button
          Align(
            alignment: Alignment.centerRight,
            child: ShadIconButton(
              onPressed: () => _showAddSheet(context),
              icon: const Icon(Icons.add),
            ),
          ),

          const Divider(),

          /// Title
          Text(
            "Transaction History",
            style: context.textTheme.headlineSmall,
          ),

          /// List
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final transactions = ref.watch(transactionspod).valueOrNull;

                if (transactions == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: transactions.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    return ListTile(
                      leading: const Icon(Icons.receipt_long),
                      title: Text(transaction.id.toString()),
                      trailing: Text(
                        '${AppCurrency.current}${transaction.amount}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: transaction.type.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => const NewTransactionPage(),
    );
  }
}
