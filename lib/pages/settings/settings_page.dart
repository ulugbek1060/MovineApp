import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SettingsPage extends StatelessWidget {

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const SettingsPage());

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(IconlyBold.arrow_left),
        ),
      ),
    );
  }
}
