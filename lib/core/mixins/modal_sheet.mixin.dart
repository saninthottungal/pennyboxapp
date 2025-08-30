import 'package:flutter/material.dart';

mixin ModalSheetMixin on Widget {
  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      elevation: 0,
      context: context,
      builder: (context) => this,
    );
  }
}
