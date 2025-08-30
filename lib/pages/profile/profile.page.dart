import 'package:flutter/material.dart';
import 'package:pennyboxapp/core/utils/context.utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: context.textTheme.bodyLarge,
      ),
    );
  }
}
