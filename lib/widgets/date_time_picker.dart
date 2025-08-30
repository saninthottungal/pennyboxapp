import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/utils/app_date.utils.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShadDateTimePicker extends StatefulWidget {
  const ShadDateTimePicker({super.key});

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
    return ShadButton.outline(
      leading: const Icon(Icons.calendar_month_outlined),
      child: Text(_selected.toSimple()),
    );
  }
}
