import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/core/utils/number.utils.dart';
import 'package:pennyboxapp/core/utils/widget.utils.dart';
import 'package:pennyboxapp/pages/home/home.logic.dart';
import 'package:pennyboxapp/services/db/models/account_with_balance.model.dart';
import 'package:pennyboxapp/sheets/delete_account/delete_account.sheet.dart';
import 'package:pennyboxapp/sheets/new_account/new_account.sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: CustomScrollView(
        slivers: [
          SizedBox(height: context.mdPadding.top + context.gutter).asSliver(),

          const Accounts(),

          const Gutter.large().asSliver(),
          Row(
            children: [
              const _QuickAction(
                icon: Icons.qr_code_scanner,
                label: 'Scan any\nQR code',
                variant: ShadButtonVariant.primary,
              ),
              const _QuickAction(
                icon: Icons.payment,
                label: 'Pay\nanyone',
                variant: ShadButtonVariant.primary,
              ),
              const _QuickAction(
                icon: Icons.account_balance,
                label: 'Bank\nTransfer',
                variant: ShadButtonVariant.primary,
              ),
              const _QuickAction(
                icon: Icons.charging_station_outlined,
                label: 'Mobile\nrecharge',
                variant: ShadButtonVariant.primary,
              ),
            ].expanded(),
          ).asSliver(),
          const Gutter.large().asSliver(),
          Text(
            "People",
            style: context.textTheme.headlineSmall,
          ).asSliver(),
          const Gutter().asSliver(),
          SliverGrid.builder(
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              return const _QuickAction(
                icon: Icons.person_2_outlined,
                label: 'Mohamed',
                variant: ShadButtonVariant.secondary,
              );
            },
          ),

          const Gutter.small().asSliver(),

          Text(
            "Bills & recharges",
            style: context.textTheme.headlineSmall,
          ).asSliver(),
          const Gutter().asSliver(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _QuickAction(
                icon: Icons.charging_station_outlined,
                label: 'Mobile\nrecharge',
                variant: ShadButtonVariant.outline,
              ),
              _QuickAction(
                icon: Icons.tv,
                label: 'DTH / Cable\nTV',
                variant: ShadButtonVariant.outline,
              ),
              _QuickAction(
                icon: Icons.emoji_objects_outlined,
                variant: ShadButtonVariant.outline,
                label: 'Electricity',
              ),
              _QuickAction(
                icon: Icons.minor_crash_outlined,
                label: 'FASTag\nrecharge',
                variant: ShadButtonVariant.outline,
              ),
            ].expanded(),
          ).asSliver(),
          const Gutter.extraLarge().asSliver(),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.variant,
  });

  final IconData icon;
  final String label;
  final ShadButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadIconButton.raw(
          variant: variant,
          height: 64,
          width: 64,
          icon: Icon(
            icon,
            size: 30,
          ),
        ),
        const Gutter.small(),
        Text(
          label,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class Accounts extends StatefulWidget {
  const Accounts();

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    final controller = AccountsProvider.of(context)
      ..getAccountBalances()
      ..initEventListner();

    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        if (controller.isLoading) {
          return const ShadCard(
            title: Text("NIL"),
            description: Text("Loading..."),
          );
        }

        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 120,
            minHeight: 105,
          ),
          child: Row(
            spacing: context.gutter,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (controller.balances.length <= 2)
                for (final account in controller.balances)
                  Expanded(
                    child: _AccountCard(
                      account,
                      onDelete: controller.deleteAccount,
                    ),
                  )
              else
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.balances.length,
                    itemBuilder: (context, index) {
                      final account = controller.balances[index];

                      return _AccountCard(
                        account,
                        onDelete: controller.deleteAccount,
                      );
                    },
                    separatorBuilder: (_, _) => const Gutter(),
                  ),
                ),

              ShadButton.outline(
                onPressed: () {
                  NewAccountSheet(
                    onAction: controller.addAccount,
                  ).show(context);
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    ).asSliver();
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard(
    this.account, {
    required this.onDelete,
  });

  final AccountwBalance account;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () => DeleteAccountSheet(
        onDelete: () => onDelete(account.id),
      ).show(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 140,
        ),
        child: ShadCard(
          padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(account.balance.toMoney()),
          ),

          description: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(account.actualBalance.toMoney()),
              ),
              Text(
                account.accountName,
                maxLines: 1,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
