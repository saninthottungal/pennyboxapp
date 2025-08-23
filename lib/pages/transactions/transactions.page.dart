import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:pennyboxapp/core/extensions/widget.ext.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.gutter,
        children: [
          SizedBox(height: context.mdPadding.top),

          Align(
            alignment: Alignment.centerRight,
            child: ShadIconButton(
              onPressed: () {
                showAddSheet(context);
              },
              icon: const Icon(Icons.add),
            ),
          ),

          const Divider(),

          Text(
            "Transaction History",
            style: context.textTheme.headlineSmall,
            textAlign: TextAlign.start,
          ),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Data $index"),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: 24,
            ),
          ),
        ],
      ),
    );
  }

  void showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return const _SheetContent();
      },
    );
  }
}

class _SheetContent extends StatelessWidget {
  const _SheetContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ShadIconButton.outline(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.close),
            ),
          ),
          const Gutter(),

          Text(
            "Amount",
            style: context.textTheme.displayLarge?.copyWith(
              color: context.colorScheme.secondary,
            ),
          ),
          const Spacer(),
          Row(
            spacing: context.gutter,
            children: [
              ShadButton.outline(
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: context.gutter,
              crossAxisSpacing: context.gutter,
              mainAxisExtent: 80,
            ),
            itemCount: chars.length,
            itemBuilder: (context, index) {
              return ShadButton.raw(
                onPressed: () {},
                variant: index == chars.length - 1
                    ? ShadButtonVariant.secondary
                    : ShadButtonVariant.outline,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: index == chars.length - 1
                      ? const Icon(
                          Icons.done,
                          size: 34,
                        )
                      : Text(
                          chars[index],
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

  static const chars = [
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
