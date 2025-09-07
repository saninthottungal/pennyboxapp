import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';

mixin SheetMixin on Widget {
  bool get useSafeArea => true;
  bool get usePadding => true;
  bool get resizeToAvoidBottomInset => true;

  Future<T?> show<T extends Object>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      elevation: 0,
      builder: (context) => SafeArea(
        top: useSafeArea,
        bottom: useSafeArea,
        left: useSafeArea,
        right: useSafeArea,
        child: Padding(
          padding: usePadding
              ? UiConsts.bodyHorizPadding.copyWith(
                  bottom: resizeToAvoidBottomInset
                      ? MediaQuery.of(context).viewInsets.bottom
                      : null,
                )
              : EdgeInsets.zero,
          child: this,
        ),
      ),
    );
  }
}
