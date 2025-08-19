import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/extensions/context.ext.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UiConsts.bodyHorizPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.gutter,
        children: [
          SizedBox(height: context.mdPadding.top),

          Align(
            alignment: Alignment.centerRight,
            child: ShadIconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ),

          const Divider(),

          Text(
            "Transaction History",
            style: context.textTheme.headlineSmall,
            textAlign: TextAlign.start,
          ),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Data $index"),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: 24,
            ),
          ),
        ],
      ),
    );
  }
}
