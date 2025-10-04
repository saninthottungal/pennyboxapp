import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/widgets/date_time_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TnxActionsRow extends StatelessWidget {
  /// DateTime picker and backspace row
  const TnxActionsRow({
    super.key,
    required this.initialDateTime,
    required this.onChanged,
    required this.onBackSpace,
    required this.onClear,
    required this.runClock,
  });

  final DateTime initialDateTime;
  final ValueChanged<DateTime> onChanged;
  final VoidCallback onBackSpace;
  final VoidCallback onClear;
  final bool runClock;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ShadDateTimePicker(
            initialDateTime: initialDateTime,
            margin: EdgeInsets.only(right: context.gutterSmall),
            onChanged: onChanged,
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: context.gutterSmall),
            child: ShadIconButton.secondary(
              onPressed: onBackSpace,
              onLongPress: onClear,
              icon: const Icon(Icons.backspace_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
