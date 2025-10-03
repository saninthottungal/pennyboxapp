import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/widgets/sheet_header.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TransactionActionSheet extends StatelessWidget with SheetMixin {
  const TransactionActionSheet({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.gutter),
      child: Column(
        spacing: context.gutterLarge,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SheetHeader(title: 'Delete/Edit Transaction'),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: context.gutter,
            children: [
              ShadButton.secondary(
                onPressed: () {
                  Navigator.of(context).pop();
                  onEdit();
                },
                leading: const Icon(Icons.edit),
                child: const Text("Edit"),
              ),
              ShadButton.destructive(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDelete();
                },
                leading: const Icon(Icons.delete_outline),
                child: const Text("Delete"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
