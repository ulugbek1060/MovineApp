import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/initialpages/page/genres_selection_page.dart';
import 'package:movie_app/utils/strings.dart';
import 'package:movie_app/theme/app_theme.dart';
import 'package:movie_app/theme/app_typography.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const OnBoardingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/on-boarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(
                    welcomeText,
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                welcomeContent,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              _submitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(GenresSelectionPage.route());
        },
        style: AppTheme.raisedButtonStyle,
        child: const Text(getStarted),
      ),
    );
  }
}
