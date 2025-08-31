import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';
import 'package:pennyboxapp/providers/theme_mode.provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: UiConsts.bodyHorizPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Dark Mode",
              style: context.textTheme.titleLarge,
            ),

            Consumer(
              builder: (context, ref, child) {
                final isDarkMode = ref.watch(isDarkThemepod);
                return ShadSwitch(
                  value: isDarkMode,
                  onChanged: ref.read(isDarkThemepod.notifier).toggle,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
