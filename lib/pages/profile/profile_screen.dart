import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/pages/settings/settings_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void navigate(BuildContext context) {
    Navigator.of(context).push(SettingsPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              navigate(context);
            },
            icon: const Icon(IconlyBold.setting),
          )
        ],
      ),
    );
  }
}
