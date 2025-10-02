import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/core/utils/number.utils.dart';
import 'package:pennyboxapp/sheets/new_transaction/new_transaction.logic.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_account_tnx_type_selector.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_actions_row.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_numpad.dart';
import 'package:pennyboxapp/sheets/select_party/select_party.sheet.dart';
import 'package:pennyboxapp/sheets/select_transfer_account/select_transfer_account.sheet.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NewTransactionSheet extends StatefulWidget with SheetMixin {
  const NewTransactionSheet({super.key});

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  _NewTransactionSheetState createState() => _NewTransactionSheetState();
}

class _NewTransactionSheetState extends State<NewTransactionSheet> {
  late final NewTransactionLogic controller;
  late final TextEditingController noteController;

  DateTime transactionAt = DateTime.now();
  @override
  void initState() {
    super.initState();
    controller = NewTransactionLogic()
      ..getAccounts()
      ..getTrancationTypes();

    noteController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.gutter),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: context.gutter,
        children: [
          ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return TnxAccountTnxTypeSelector(
                accounts: controller.accounts,
                tnxTypes: controller.transactionTypes,
                initialAccount: controller.selectedAccount,
                initialTnx: controller.selectedTxnType,
                onAccountSelected: controller.updateSelectedAccount,
                onTnxTypeSelected: controller.updateSelectedTransactionType,
              );
            },
          ),

          //* Other Party/ Transfer Account
          Expanded(
            child: Column(
              spacing: context.gutterSmall,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    if (controller.selectedTxnType == null) {
                      return const SizedBox.shrink();
                    }

                    return GestureDetector(
                      onTap: () {
                        if (controller.selectedTxnType == TxnType.transfer) {
                          SelectTransferAccountSheet(
                            onSelected: controller.updateTransferringTo,
                          ).show(context);
                        } else {
                          SelectPartySheet(
                            onSelected: controller.updateParty,
                          ).show(context);
                        }
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration:
                            controller.selectedParty != null ||
                                controller.transferringTo != null
                            ? null
                            : BoxDecoration(
                                border: Border.all(
                                  //! needs to define a color for this
                                  color: context.colorScheme.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                                borderRadius: UiConsts.borderRadius,
                              ),
                        child: Text(
                          '${controller.selectedTxnType?.actionLabel}'
                          ' ${controller.selectedTxnType == TxnType.transfer ? controller.transferringTo?.name ?? '?' : controller.selectedParty?.name ?? '?'}',
                          textAlign: TextAlign.center,
                          //! needs to define a color for this
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: controller.selectedParty == null
                                //! needs to define a color for this
                                ? context.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  )
                                : context.colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                //* Amount
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    final amount = double.tryParse(controller.amount) ?? 0;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: context.gutter),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          amount.toMoney(),
                          maxLines: 1,
                          style: context.textTheme.displayLarge?.copyWith(
                            color: amount == 0
                                ? context.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  )
                                : context.colorScheme.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                //* add a note
                IntrinsicWidth(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 100,
                      maxWidth: context.mdSize.width * 0.7,
                    ),
                    child: ShadInput(
                      controller: noteController,
                      textCapitalization: TextCapitalization.sentences,
                      placeholderAlignment: Alignment.center,
                      textAlign: TextAlign.center,
                      placeholder: const Text("Add note"),
                      minLines: 1,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Actions row
          TnxActionsRow(
            initialDateTime: transactionAt,
            onChanged: (value) => transactionAt = value,
            onBackSpace: controller.backSpace,
            onClear: controller.clear,
          ),

          /// Number pad
          TnxNumPad(
            onPressed: controller.append,
            onDone: () async {
              final note = noteController.text.trim();

              final success = await controller.addTransaction(
                transactionAt: transactionAt,
                description: note.isNotEmpty ? note : null,
              );
              if (context.mounted && success) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
