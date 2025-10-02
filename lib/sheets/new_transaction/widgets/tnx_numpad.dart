import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TnxNumPad extends StatelessWidget {
  const TnxNumPad({
    super.key,
    required this.onPressed,
    required this.onDone,
  });

  final ValueChanged<String> onPressed;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
              onDone();
            } else {
              onPressed(char);
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
