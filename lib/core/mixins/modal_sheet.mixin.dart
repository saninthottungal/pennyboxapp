import 'package:flutter/material.dart';

mixin ModalSheetMixin on Widget {
  Future<T?> show<T extends Object>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      elevation: 0,
      builder: (context) => this,
    );
  }
}
