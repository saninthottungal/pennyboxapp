import 'package:flutter/material.dart';

extension WidgetEXT on Widget {
  Widget asSliver() => SliverToBoxAdapter(child: this);
}
