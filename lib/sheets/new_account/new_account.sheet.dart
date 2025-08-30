import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/sheets/new_account/new_account.logic.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _formKey = GlobalKey<FormState>();

class NewAccountSheet extends HookConsumerWidget with ModalSheetMixin {
  const NewAccountSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Account",
                  style: context.textTheme.titleLarge,
                ),

                ShadIconButton.outline(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  await ref
                      .read(newAccountpod.notifier)
                      .addAccount(
                        controller.text,
                      );
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
