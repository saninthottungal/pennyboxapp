import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/utils/app_date.utils.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/core/utils/number.utils.dart';
import 'package:pennyboxapp/pages/transactions/transactions.logic.dart';
import 'package:pennyboxapp/sheets/delete_transaction/delete_transaction.logic.dart';
import 'package:pennyboxapp/sheets/delete_transaction/delete_transaction.sheet.dart';
import 'package:pennyboxapp/sheets/new_transaction/new_transaction.sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConsts.bodyHorizPadding.copyWith(
        top: context.mdPadding.top + context.gutter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.gutter,
        children: [
          /// Add button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ShadIconButton(
                onPressed: () => const NewTransactionSheet().show(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Row(
            spacing: context.gutter,
            children: const [
              Expanded(
                child: ShadInput(
                  placeholder: Text("Search Transactions"),
                  leading: Icon(Icons.search),
                ),
              ),

              ShadIconButton.outline(
                icon: Icon(Icons.filter_list),
              ),
            ],
          ),

          const Divider(),

          //* See planned transactions
          Consumer(
            builder: (context, ref, child) {
              final plannedCount =
                  ref.watch(hasPlannedTransactionsPod).value ?? 0;

              if (plannedCount <= 0) return const SizedBox.shrink();

              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: ShapeDecoration(
                    shape: UiConsts.shapeBoder.copyWith(
                      side: BorderSide(
                        color: context.colorScheme.secondary,
                        strokeAlign: 0,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "See $plannedCount planned transactions",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_outlined,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          /// List
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final transactions = ref.watch(getTransactionspod).valueOrNull;

                if (transactions == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: transactions.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    return ListTile(
                      //TODO: Delete should be SOFT
                      onLongPress: () => DeleteTransactionSheet(
                        onDelete: () => ref
                            .read(deleteTransactionpod.notifier)
                            .delete(transaction.id),
                      ).show(context),
                      leading: Container(
                        decoration: ShapeDecoration(
                          shape: UiConsts.shapeBoder,
                          color: transaction.type.color,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          transaction.type.icon,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        transaction.party?.name ?? transaction.id.toString(),
                      ),
                      subtitle: Text.rich(
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: transaction.transactionAt.toSimple(),
                          children: transaction.description != null
                              ? [
                                  const TextSpan(text: '\n'),
                                  TextSpan(text: transaction.description),
                                ]
                              : [],
                        ),
                        maxLines: 3,
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,

                          //! needs change
                          color: context.colorScheme.primary.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),

                      trailing: Text(
                        transaction.amount.toMoney(),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: transaction.type.color,
                          fontWeight: FontWeight.w700,
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
}
