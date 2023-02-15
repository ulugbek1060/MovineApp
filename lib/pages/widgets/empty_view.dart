import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        IconlyBold.document,
        size: 100,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
