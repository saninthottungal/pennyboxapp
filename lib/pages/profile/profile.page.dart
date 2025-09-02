import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/constants/ui_conts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: UiConsts.bodyHorizPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          ///* will be implemented later - May be -
          // children: [
          //   Text(
          //     "Dark Mode",
          //     style: context.textTheme.titleLarge,
          //   ),

          //   Consumer(
          //     builder: (context, ref, child) {
          //       final isDarkMode = ref.watch(isDarkThemepod);
          //       return ShadSwitch(
          //         value: isDarkMode,
          //         onChanged: ref.read(isDarkThemepod.notifier).toggle,
          //       );
          //     },
          //   ),
          // ],
        ),
      ),
    );
  }
}
