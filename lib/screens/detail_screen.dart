import 'package:flutter/material.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late SolidController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SolidController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // Main background of screen with movie image with animation
      body: StreamBuilder<double>(
        stream: _controller.heightStream,
        initialData: 0.0,
        builder: (_, snapshot) {
          return AnimatedContainer(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 100),
            height: height * 0.8 - snapshot.data!,
            width: double.infinity,
            child: Hero(
              tag: 12,
              child: Image.asset(
                'assets/images/on-boarding.png',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),

      // Bottom sheet with some information
      bottomSheet: SolidBottomSheet(
        maxHeight: height * 0.3,
        controller: _controller,
        draggableBody: true,
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: height * 0.3,
          child: const Center(
            child: Text("Swipe me!"),
          ),
        ),

        // movies list depnd on type of movies
        body: Container(
          color: Theme.of(context).primaryColor,
          child: const Center(
            child: Text(
              "Hello! I'm a bottom sheet :D",
              style: AppTypography.labelLarge,
            ),
          ),
        ),
      ),
    );
  }
}
