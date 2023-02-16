import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/utils/strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(profile),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.shield_moon_rounded,
                  color: Theme.of(context).colorScheme.onBackground),
              title: const Text('Dark Mode', style: AppTypography.labelLarge),
              trailing:
                  Switch.adaptive(value: false, onChanged: (bool newValue) {}),
            ),
            ListTile(
              leading: Icon(Icons.language,
                  color: Theme.of(context).colorScheme.onBackground, size: 30),
              title: const Text('Language', style: AppTypography.labelLarge),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ),
    );
  }
}
