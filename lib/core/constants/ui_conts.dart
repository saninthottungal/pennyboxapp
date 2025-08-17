import 'package:flutter/widgets.dart';

class UiConsts {
  UiConsts._();

  static const bodyHorizPadding = EdgeInsets.symmetric(horizontal: 16);
  static const borderRadius = BorderRadius.all(Radius.circular(8));

  static const shapeBoder = RoundedSuperellipseBorder(
    borderRadius: borderRadius,
  );
}
