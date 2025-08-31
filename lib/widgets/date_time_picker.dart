import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/utils/app_date.utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShadDateTimePicker extends StatefulWidget {
  const ShadDateTimePicker({
    super.key,
    required this.onSelected,
    this.margin,
  });

  final ValueChanged<DateTime> onSelected;
  final EdgeInsets? margin;

  @override
  State<ShadDateTimePicker> createState() => _ShadDateTimePickerState();
}

class _ShadDateTimePickerState extends State<ShadDateTimePicker> {
  DateTime _selected = DateTime.now();
  late final Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => _selected = DateTime.now()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: ShadButton.outline(
        onPressed: () async {
          final dateTime = await _showDateTimeDialogue(context);

          if (dateTime != null) {
            //* cancelling the _timer is necessary here.
            _timer.cancel();
            setState(() {
              _selected = dateTime;
            });

            widget.onSelected(dateTime);
          }
        },
        leading: const Icon(Icons.calendar_month_outlined),
        child: Text(_selected.toSimple()),
      ),
    );
  }

  Future<DateTime?> _showDateTimeDialogue(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: DateTime.now(),
    );
    if (!context.mounted || date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (!context.mounted || time == null) return null;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    return dateTime;
  }
}
