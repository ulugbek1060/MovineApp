import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/pages/settings/settings_page.dart';
import 'package:movie_app/theme/app_typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void navigate(BuildContext context) {
    Navigator.of(context).push(SettingsPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Profile'),
              pinned: true,
            ),
            SliverPaddingContainer(
              child: Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                    child:  SvgPicture.asset(
                      'assets/images/logo.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverPaddingContainer(
              top: 20,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.shield_moon_rounded,
                      color: Colors.white,
                    ),
                    title: const Expanded(
                      child: Text(
                        'Dark Mode',
                        style: AppTypography.labelLarge,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    trailing: Switch.adaptive(
                      value: false,
                      onChanged: (bool newValue) {},
                    ),
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      'Language',
                      style: AppTypography.labelLarge,
                      textAlign: TextAlign.justify,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverPaddingContainer extends SliverToBoxAdapter {
  final double top;
  final double right;
  final double left;
  final double bottom;

  SliverPaddingContainer({
    super.key,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
    required Widget child,
  }) : super(
          child: Padding(
            padding: EdgeInsets.only(
              top: top,
              left: left,
              right: right,
              bottom: bottom,
            ),
            child: child,
          ),
        );
}
