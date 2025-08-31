import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SheetHeader extends StatelessWidget {
  const SheetHeader({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.textTheme.titleLarge,
          ),

        const Spacer(),

        ShadIconButton.outline(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
