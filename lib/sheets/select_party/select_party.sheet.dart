import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/widgets/sheet_header.dart';

class SelectPartySheet extends ConsumerWidget with SheetMixin {
  const SelectPartySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.gutter),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.mdSize.height * 0.5,
        ),
        child: const Column(
          children: [
            SheetHeader(title: 'Select Party'),
          ],
        ),
      ),
    );
  }
}
