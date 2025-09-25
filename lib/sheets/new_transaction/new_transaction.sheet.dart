import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/core/mixins/modal_sheet.mixin.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/core/utils/number.utils.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/sheets/new_transaction/new_transaction.logic.dart';
import 'package:pennyboxapp/sheets/select_party/select_party.sheet.dart';
import 'package:pennyboxapp/widgets/date_time_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NewTransactionSheet extends StatefulHookConsumerWidget with SheetMixin {
  const NewTransactionSheet({super.key});

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  _NewTransactionSheetState createState() => _NewTransactionSheetState();
}

class _NewTransactionSheetState extends ConsumerState<NewTransactionSheet> {
  late final NewTransactionLogic controller;
  @override
  void initState() {
    super.initState();
    controller = NewTransactionLogic()
      ..getAccounts()
      ..getTrancationTypes();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionAt = useRef<DateTime>(DateTime.now());
    final noteController = useTextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.gutter),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: context.gutter,
        children: [
          Row(
            spacing: context.gutter,
            children: [
              //* Account Types
              ListenableBuilder(
                listenable: controller,
                builder: (context, _) {
                  return ShadSelect<Account>(
                    initialValue: controller.selectedAccount,
                    placeholder: const Text("Account"),
                    selectedOptionBuilder: (context, value) {
                      return Text(value.name);
                    },
                    options: controller.accounts.map((e) {
                      return ShadOption(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
                    onChanged: controller.updateSelectedAccount,
                  );
                },
              ),

              //* TransactionTypes
              ListenableBuilder(
                listenable: controller,
                builder: (context, child) {
                  return ShadSelect<TxnType>(
                    initialValue: controller.selectedTxnType,
                    placeholder: const Text("Transaction"),
                    selectedOptionBuilder: (context, value) {
                      return Text(value.asText);
                    },
                    options: controller.transactionTypes.map((e) {
                      return ShadOption(
                        value: e,
                        child: Text(e.asText),
                      );
                    }).toList(),
                    onChanged: controller.updateSelectedTransactionType,
                  );
                },
              ),

              const Spacer(),

              ShadIconButton.outline(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          //* Other Party
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
                      onTap: () => SelectPartySheet(
                        onSelected: controller.updateParty,
                      ).show(context),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: controller.selectedParty != null
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
                          '${controller.selectedTxnType?.actionLabel} ${controller.selectedParty?.name ?? '?'}',
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
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ShadDateTimePicker(
                  initialDateTime: transactionAt.value,
                  margin: EdgeInsets.only(right: context.gutterSmall),
                  onChanged: (value) => transactionAt.value = value,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: context.gutterSmall),
                  child: ShadIconButton.secondary(
                    onPressed: controller.backSpace,
                    onLongPress: controller.clear,
                    icon: const Icon(Icons.backspace_outlined),
                  ),
                ),
              ),
            ],
          ),

          /// Number pad
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: context.gutter,
              crossAxisSpacing: context.gutter,
              mainAxisExtent: 60,
            ),
            itemCount: _chars.length,
            itemBuilder: (context, index) {
              final char = _chars[index];
              final isDoneBtn = index == _chars.length - 1;

              return ShadButton.raw(
                onPressed: () async {
                  if (isDoneBtn) {
                    final note = noteController.text.trim();

                    await controller.addTransaction(
                      transactionAt: transactionAt.value,
                      description: note.isNotEmpty ? note : null,
                    );
                    if (context.mounted) Navigator.pop(context);
                  } else {
                    controller.append(char);
                  }
                },
                variant: isDoneBtn
                    ? ShadButtonVariant.primary
                    : ShadButtonVariant.outline,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: isDoneBtn
                      ? const Icon(Icons.done, size: 34)
                      : Text(
                          char,
                          style: context.textTheme.displayMedium?.copyWith(
                            color: context.colorScheme.primary,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static const List<String> _chars = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '',
  ];
}
