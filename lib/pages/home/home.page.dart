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
          const Gutter().asSliver(),
          Row(
            spacing: context.gutter,
            children: [
              const _QuickAction(
                icon: Icons.qr_code_scanner,
                label: 'Scan any\n QR code',
              ),
              const _QuickAction(
                icon: Icons.payment,
                label: 'Pay\n anyone',
              ),
              const _QuickAction(
                icon: Icons.account_balance,
                label: 'Bank\n Transfer',
              ),
              const _QuickAction(
                icon: Icons.charging_station_outlined,
                label: 'Mobile\n recharge',
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: context.colorScheme.secondary,
                    child: Icon(
                      Icons.person_2_outlined,
                      size: 28,
                      color: context.colorScheme.onSecondary,
                    ),
                  ),
                  const Gutter.small(),
                  Text(
                    "Mohamed",
                    style: context.textTheme.labelLarge,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: ShapeDecoration(
            shape: UiConsts.shapeBoder,
            color: context.colorScheme.secondary,
          ),
          child: Icon(
            icon,
            color: context.colorScheme.onSecondary,
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
