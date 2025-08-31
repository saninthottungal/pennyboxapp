import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/widgets/sheet_header.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DeleteTransactionSheet extends StatelessWidget with SheetMixin {
  const DeleteTransactionSheet({
    super.key,
    required this.onDelete,
  });

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.gutter),
      child: Column(
        spacing: context.gutter,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SheetHeader(title: 'Delete Transaction?'),
          const SizedBox(
            width: double.infinity,
            child: Text("Caution: This action cannot be undone!"),
          ),
          ShadButton.destructive(
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
            leading: const Icon(Icons.delete_outline),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
