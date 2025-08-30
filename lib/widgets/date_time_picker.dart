import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/utils/app_date.utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShadDateTimePicker extends StatefulWidget {
  const ShadDateTimePicker({super.key});

  @override
  State<ShadDateTimePicker> createState() => _ShadDateTimePickerState();
}

class _ShadDateTimePickerState extends State<ShadDateTimePicker> {
  late final ShadPopoverController _controller;
  DateTime selected = DateTime.now();

  @override
  void initState() {
    super.initState();

    _controller = ShadPopoverController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadPopover(
      padding: EdgeInsets.zero,
      controller: _controller,
      popover: (context) {
        return ShadCalendar(
          showOutsideDays: false,
          selectableDayPredicate: DateTime.now().isAfter,
          onChanged: (value) {
            setState(() {
              selected = value ?? DateTime.now();
            });

            if (_controller.isOpen) _controller.toggle();
          },
        );
      },
      child: ShadButton.outline(
        leading: const Icon(Icons.calendar_month_outlined),
        onPressed: _controller.toggle,
        child: Text(selected.toSimple()),
      ),
    );
  }
}
