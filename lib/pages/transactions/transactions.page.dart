import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/utils/app_date.utils.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/core/utils/number.utils.dart';
import 'package:pennyboxapp/pages/transactions/transactions.logic.dart';
import 'package:pennyboxapp/services/db/models/transaction.model.dart';
import 'package:pennyboxapp/sheets/delete_transaction/delete_transaction.sheet.dart';
import 'package:pennyboxapp/sheets/new_transaction/new_transaction.sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TransactionsProvider.of(context);

    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  "Transactions",
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: false,
                titleSpacing: 0,
                pinned: true,
                surfaceTintColor: context.colorScheme.surface,
                actions: [
                  ShadIconButton(
                    onPressed: () => const NewTransactionSheet().show(context),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              SliverAppBar(
                primary: false,
                titleSpacing: 0,
                floating: true,
                snap: true,
                title: Row(
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
                surfaceTintColor: context.colorScheme.surface,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      shape: UiConsts.shapeBoder,
                      color: context.colorScheme.secondary,
                    ),
                    child: TabBar(
                      tabs: const [
                        Tab(text: 'History'),
                        Tab(text: 'Upcoming'),
                      ],
                      dividerColor: Colors.transparent,
                      dividerHeight: 0,
                      indicatorWeight: 0,

                      padding: EdgeInsets.zero,
                      indicator: ShapeDecoration(
                        shape: UiConsts.shapeBoder,
                        color: context.colorScheme.surface,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsetsGeometry.all(6),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              //* transaction history
              ListenableBuilder(
                listenable: controller,
                builder: (context, child) {
                  return _TransactionListView(controller.history);
                },
              ),

              //* Upcoming/Planned Transactions
              ListenableBuilder(
                listenable: controller,
                builder: (context, child) {
                  return _TransactionListView(controller.planned);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionListView extends StatelessWidget {
  const _TransactionListView(this.transactions);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final controller = TransactionsProvider.of(context);

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: transactions.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return ListTile(
          //TODO: Delete should be SOFT
          onLongPress: () => DeleteTransactionSheet(
            onDelete: () => controller.delete(transaction.id),
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
            transaction.party?.name ?? transaction.account.name,
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
  }
}
