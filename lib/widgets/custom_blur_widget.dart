import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class CustomBluerWidget extends StatelessWidget {
  final Widget child;
  double margin;
  double padding;

  CustomBluerWidget({
    Key? key,
    required this.child,
    this.margin = 12,
    this.padding = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.white.withAlpha(30),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: BlurryContainer(
        blur: 4,
        elevation: 0,
        color: const Color(0x20FFFFFF),
        padding: EdgeInsets.all(padding),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: child,
      ),
    );
  }
}
