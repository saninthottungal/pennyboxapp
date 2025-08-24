import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:pennyboxapp/core/extensions/widget.ext.dart';
import 'package:pennyboxapp/pages/new_transaction/new_transaction.logic.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NewTransactionPage extends ConsumerWidget {
  const NewTransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pod = newTransactionAmountpod;

    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: context.gutter,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ShadIconButton.outline(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.close),
            ),
          ),

          Expanded(
            child: Center(
              child: Consumer(
                builder: (context, ref, child) {
                  final amount = ref.watch(pod);

                  return Text(
                    '\$${amount.isEmpty ? 0 : amount}',
                    style: context.textTheme.displayLarge?.copyWith(
                      color: amount.isEmpty
                          ? context.colorScheme.secondary
                          : context.colorScheme.primary,
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
                onPressed: ref.read(pod.notifier).clear,
                child: Text(
                  'AC',
                  style: context.textTheme.bodyLarge,
                ),
              ),
              const ShadButton.outline(),
              ShadIconButton.outline(
                onPressed: ref.read(pod.notifier).backSpace,
                icon: const Icon(Icons.backspace_outlined),
              ),
            ].expanded(),
          ),

          /// Number pad
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: context.gutter,
              crossAxisSpacing: context.gutter,
              mainAxisExtent: 60,
            ),
            itemCount: _chars.length,
            itemBuilder: (context, index) {
              final char = _chars[index];
              final isDoneBtn = index == _chars.length - 1;

              return ShadButton.raw(
                onPressed: () {
                  if (isDoneBtn) {
                    // final value = ref.read(pod.notifier).state;
                    // final amount = double.parse(value);
                    // ref.read(appDbpod).transactionsDao.addTransaction(amount);
                  } else {
                    ref.read(pod.notifier).append(char);
                  }
                },
                variant: isDoneBtn
                    ? ShadButtonVariant.primary
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
