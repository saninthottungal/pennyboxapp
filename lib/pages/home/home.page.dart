import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: context.mdPadding.top),
        const Gutter(),
        const Row(
          children: [
            Gutter(),
            Expanded(
              child: ShadCard(
                title: Text("\$450000"),
                description: Text("Cash"),
              ),
            ),
            Gutter(),
            Expanded(
              child: ShadCard(
                title: Text("\$64.07"),
                description: Text("SANIN T"),
              ),
            ),
            Gutter(),
          ],
        ),
      ],
    );
  }
}
