import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/services/database/app_database.dart';
import 'package:pennyboxapp/sheets/select_party/select_party.logic.dart';
import 'package:pennyboxapp/widgets/sheet_header.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _formKey = GlobalKey<FormState>();

class SelectPartySheet extends HookConsumerWidget with SheetMixin {
  const SelectPartySheet({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<Party> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = useTextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.gutter),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.mdSize.height * 0.5,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: context.gutter,
            children: [
              const SheetHeader(title: 'Select Party'),
              Row(
                spacing: context.gutter,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ShadInputFormField(
                      controller: inputController,
                      placeholder: const Text("Search"),
                      textCapitalization: TextCapitalization.words,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.trim().length < 2) {
                          return 'Name should atleast have two characters';
                        }

                        return null;
                      },
                    ),
                  ),
                  ShadButton.secondary(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(partiespod.notifier)
                            .addParty(inputController.text);

                        inputController.clear();
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),

              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final parties = ref.watch(partiespod).value;

                    if (parties == null) return const SizedBox.shrink();

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final party = parties[index];

                        return GestureDetector(
                          onTap: () {
                            onSelected(party);
                            Navigator.of(context).pop();
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Card(
                            color: context.colorScheme.secondaryContainer,
                            child: ListTile(
                              leading: Text(
                                party.id.toString(),
                                style: context.textTheme.titleSmall,
                              ),
                              title: Text(
                                party.name,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, _) => const Gutter(),
                      itemCount: parties.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
