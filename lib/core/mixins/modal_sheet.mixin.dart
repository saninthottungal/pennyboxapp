import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';

mixin SheetMixin on Widget {
  Future<T?> show<T extends Object>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      elevation: 0,
      builder: (context) => SafeArea(
        child: Padding(
          padding: UiConsts.bodyHorizPadding.copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: this,
        ),
      ),
    );
  }
}
