import 'package:flutter/material.dart';
import 'package:movie_app/l10n/l10n.dart';
import 'package:movie_app/theme/app_typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.shield_moon_rounded,
                  color: Theme.of(context).colorScheme.onBackground),
              title: Text(context.l10n.darkMode, style: AppTypography.labelLarge),
              trailing:
                  Switch.adaptive(value: false, onChanged: (bool newValue) {}),
            ),
            ListTile(
              leading: Icon(Icons.language,
                  color: Theme.of(context).colorScheme.onBackground, size: 30),
              title: Text(context.l10n.language, style: AppTypography.labelLarge),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ),
    );
  }
}
