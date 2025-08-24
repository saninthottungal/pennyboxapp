import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:pennyboxapp/core/extensions/widget.ext.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
      builder: (_) => const _AddTransactionSheet(),
    );
  }
}

/// Bottom Sheet
class _AddTransactionSheet extends ConsumerWidget {
  const _AddTransactionSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: context.gutter,
        children: [
          /// Close button
          Align(
            alignment: Alignment.centerRight,
            child: ShadIconButton.outline(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.close),
            ),
          ),

          /// Amount text
          Expanded(
            child: Center(
              child: Consumer(
                builder: (context, ref, child) {
                  final amount = ref.watch(amountPod);

                  return Text(
                    amount.isEmpty ? "Amount" : amount,
                    style: context.textTheme.displayLarge?.copyWith(
                      color: context.colorScheme.secondary,
                    ),
                  );
                },
              ),
            ),
          ),

          /// Actions row
          Row(
            spacing: context.gutter,
            children: [
              ShadButton.outline(
                onPressed: () {},
                child: Text(
                  'AC',
                  style: context.textTheme.bodyLarge,
                ),
              ),
              const ShadButton.outline(),
              const ShadIconButton.outline(
                icon: Icon(Icons.backspace_outlined),
              ),
            ].expanded(),
          ),

          const Gutter(),

          /// Number pad
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: context.gutter,
              crossAxisSpacing: context.gutter,
              mainAxisExtent: 80,
            ),
            itemCount: _chars.length,
            itemBuilder: (context, index) {
              final char = _chars[index];
              final isDoneBtn = index == _chars.length - 1;

              return ShadButton.raw(
                onPressed: () {
                  if (isDoneBtn) {
                    final value = ref.read(amountPod.notifier).state;
                    final amount = double.parse(value);
                    ref.read(appDbpod).transactionsDao.addTransaction(amount);
                  } else {
                    final pod = ref.read(amountPod.notifier);
                    pod.state = '${pod.state}$char';
                  }
                },
                variant: isDoneBtn
                    ? ShadButtonVariant.secondary
                    : ShadButtonVariant.outline,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: isDoneBtn
                      ? const Icon(Icons.done, size: 34)
                      : Text(
                          char,
                          style: context.textTheme.displayMedium?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static const List<String> _chars = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '',
  ];
}

final transactionsPod = StreamProvider((ref) {
  final db = ref.watch(appDbpod);
  return db.transactionsDao.transactionsStream();
});

final amountPod = StateProvider((ref) {
  return '';
});
