import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/sheets/new_transaction/new_transaction.logic.dart';
import 'package:pennyboxapp/sheets/new_transaction/new_transaction.sheet.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_account_tnx_type_selector.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_actions_row.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_numpad.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_other_party_selector.dart';
import 'package:pennyboxapp/sheets/select_party/select_party.sheet.dart';
import 'package:pennyboxapp/sheets/select_transfer_account/select_transfer_account.sheet.dart';

class EditTransactionSheet extends StatefulWidget with SheetMixin {
  const EditTransactionSheet({
    super.key,
    required this.transactionId,
  });

  final String transactionId;

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  _EditTransactionSheetState createState() => _EditTransactionSheetState();
}

class _EditTransactionSheetState extends State<EditTransactionSheet> {
  late final NewTransactionLogic controller;
  late final TextEditingController noteController;

  DateTime transactionAt = DateTime.now();
  @override
  void initState() {
    super.initState();
    controller = NewTransactionLogic();

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

                    return OtherPartySelector(
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
                      selectedParty: controller.selectedParty,
                      transferringTo: controller.transferringTo,
                      selectedTxnType: controller.selectedTxnType,
                    );
                  },
                ),

                //* Amount
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, child) {
                    final amount = double.tryParse(controller.amount) ?? 0;

                    return AmountWidget(amount: amount);
                  },
                ),

                //* add a note
                AddNoteWidget(noteController: noteController),
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

            //! change onDone
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
