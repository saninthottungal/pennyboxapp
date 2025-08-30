import 'package:flutter/material.dart';

extension WidgetEXT on Widget {
  Widget asSliver() => SliverToBoxAdapter(child: this);
}

extension ListOfWidgetEXT on List<Widget> {
  List<Widget> expanded() => map((e) => Expanded(child: e)).toList();
}
