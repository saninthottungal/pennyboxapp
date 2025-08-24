import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:pennyboxapp/pages/new_transaction/new_transaction.page.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
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
                final transactions = ref.watch(transactionsPod).valueOrNull;

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
                    return ListTile(
                      leading: const Icon(Icons.receipt_long),
                      title: Text("Transaction $index"),
                      subtitle: const Text("Some details here"),
                      trailing: Text(
                        "-\$${(index + 1) * 5}",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.error,
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

final transactionsPod = StreamProvider((ref) {
  final db = ref.watch(appDbpod);
  return db.transactionsDao.transactionsStream();
});
