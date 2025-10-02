import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/core/utils/number.utils.dart';
import 'package:pennyboxapp/sheets/new_transaction/new_transaction.logic.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_account_tnx_type_selector.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_actions_row.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_numpad.dart';
import 'package:pennyboxapp/sheets/new_transaction/widgets/tnx_other_party_selector.dart';
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

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key,
    required this.amount,
  });

  final double amount;

  @override
  Widget build(BuildContext context) {
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
  }
}

class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({
    super.key,
    required this.noteController,
  });

  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
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
    );
  }
}
