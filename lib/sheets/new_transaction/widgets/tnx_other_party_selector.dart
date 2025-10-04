import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/enums/transaction_type.enum.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/services/db/models/account.model.dart';
import 'package:pennyboxapp/services/db/models/party.model.dart';

class OtherPartySelector extends StatelessWidget {
  const OtherPartySelector({
    super.key,
    required this.onTap,
    required this.selectedParty,
    required this.transferringTo,
    required this.selectedTxnType,
  });

  final VoidCallback onTap;

  final Party? selectedParty;
  final Account? transferringTo;
  final TxnType? selectedTxnType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        decoration: selectedParty != null || transferringTo != null
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
          '${selectedTxnType?.actionLabel}'
          ' ${selectedTxnType == TxnType.transfer ? transferringTo?.name ?? '?' : selectedParty?.name ?? '?'}',
          textAlign: TextAlign.center,
          //! needs to define a color for this
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: selectedParty == null && transferringTo == null
                //! needs to define a color for this
                ? context.colorScheme.primary.withValues(alpha: 0.3)
                : context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
