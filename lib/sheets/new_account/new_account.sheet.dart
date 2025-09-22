import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/widgets/sheet_header.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _formKey = GlobalKey<FormState>();

class NewAccountSheet extends HookWidget with SheetMixin {
  const NewAccountSheet({
    super.key,
    required this.onAction,
  });

  final ValueChanged<String> onAction;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.gutter),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: context.gutter,
          children: [
            const SheetHeader(title: 'Add Account'),
            ShadInputFormField(
              controller: controller,
              placeholder: const Text("Account Name"),
              textCapitalization: TextCapitalization.words,
              leading: const Icon(Icons.switch_account_outlined),
              description: const Text("Account name must be unique."),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.trim().length < 2) {
                  return 'Account name must have atleast two characters';
                }

                return null;
              },
            ),

            ShadButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  onAction(controller.text);
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (context.mounted) Navigator.of(context).pop();
                }
              },
              child: const Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}
