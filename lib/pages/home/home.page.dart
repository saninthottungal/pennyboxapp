import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:pennyboxapp/core/extensions/widget.ext.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: CustomScrollView(
        slivers: [
          SizedBox(height: context.mdPadding.top).asSliver(),
          const Gutter().asSliver(),
          const Row(
            children: [
              Expanded(
                child: ShadCard(
                  title: Text("\$450000"),
                  description: Text("Cash"),
                ),
              ),
              Gutter(),
              Expanded(
                child: ShadCard(
                  title: Text("\$64.07"),
                  description: Text("SANIN T"),
                ),
              ),
            ],
          ).asSliver(),
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
