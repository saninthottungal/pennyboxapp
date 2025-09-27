import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/sheets/select_transfer_account/select_transfer_account.logic.dart';
import 'package:pennyboxapp/widgets/sheet_header.dart';

final _formKey = GlobalKey<FormState>();

class SelectTransferAccountSheet extends StatefulWidget with SheetMixin {
  const SelectTransferAccountSheet({
    super.key,
    required this.onSelected,
  });

  final ValueChanged<Account> onSelected;

  @override
  _SelectTransferAccountSheetState createState() =>
      _SelectTransferAccountSheetState();
}

class _SelectTransferAccountSheetState
    extends State<SelectTransferAccountSheet> {
  late final SelectTransferLogic controller;
  late final TextEditingController inputController;

  @override
  void initState() {
    super.initState();
    controller = SelectTransferLogic();
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
              const SheetHeader(title: 'Select Account'),

              Expanded(
                child: ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final account = controller.accounts[index];

                        return GestureDetector(
                          onTap: () {
                            widget.onSelected(account);
                            Navigator.of(context).pop();
                          },
                          behavior: HitTestBehavior.translucent,
                          child: Card(
                            color: context.colorScheme.secondaryContainer,
                            child: ListTile(
                              leading: Text(
                                account.id.toString(),
                                style: context.textTheme.titleSmall,
                              ),
                              title: Text(
                                account.name,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, _) => const Gutter(),
                      itemCount: controller.accounts.length,
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
