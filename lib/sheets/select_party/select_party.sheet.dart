import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';
import 'package:pennyboxapp/sheets/select_party/select_party.logic.dart';
import 'package:pennyboxapp/widgets/sheet_header.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _formKey = GlobalKey<FormState>();

class SelectPartySheet extends StatefulWidget with SheetMixin {
  const SelectPartySheet({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<Party> onSelected;

  @override
  _SelectPartySheetState createState() => _SelectPartySheetState();
}

class _SelectPartySheetState extends State<SelectPartySheet> {
  late final SelectPartyLogic controller;
  late final TextEditingController inputController;

  @override
  void initState() {
    super.initState();
    controller = SelectPartyLogic();
    inputController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      trailing: GestureDetector(
                        onTap: inputController.clear,
                        behavior: HitTestBehavior.translucent,
                        child: const Icon(Icons.close),
                      ),
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
                      onChanged: controller.searchParties,
                    ),
                  ),
                  ShadButton.secondary(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.addParty(inputController.text);

                        inputController.clear();
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),

              Expanded(
                child: ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final party = controller.parties[index];

                        return GestureDetector(
                          onTap: () {
                            widget.onSelected(party);
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
                      itemCount: controller.parties.length,
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
