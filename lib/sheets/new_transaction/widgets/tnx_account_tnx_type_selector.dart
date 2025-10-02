import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TnxAccountTnxTypeSelector extends StatelessWidget {
  const TnxAccountTnxTypeSelector({
    super.key,
    required this.accounts,
    required this.onAccountSelected,
    required this.initialAccount,
    required this.tnxTypes,
    required this.onTnxTypeSelected,
    required this.initialTnx,
  });

  final List<Account> accounts;
  final ValueChanged<Account?> onAccountSelected;
  final Account? initialAccount;

  final List<TxnType> tnxTypes;
  final ValueChanged<TxnType?> onTnxTypeSelected;
  final TxnType? initialTnx;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.gutter,
      children: [
        //* Account Types
        ShadSelect<Account>(
          initialValue: initialAccount,
          placeholder: const Text("Account"),
          selectedOptionBuilder: (context, value) {
            return Text(value.name);
          },
          options: accounts.map((e) {
            return ShadOption(
              value: e,
              child: Text(e.name),
            );
          }).toList(),
          onChanged: onAccountSelected,
        ),

        //* TransactionTypes
        ShadSelect<TxnType>(
          initialValue: initialTnx,
          placeholder: const Text("Transaction"),
          selectedOptionBuilder: (context, value) {
            return Text(value.asText);
          },
          options: tnxTypes.map((e) {
            return ShadOption(
              value: e,
              child: Text(e.asText),
            );
          }).toList(),
          onChanged: onTnxTypeSelected,
        ),

        const Spacer(),

        ShadIconButton.outline(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
