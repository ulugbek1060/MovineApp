import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/strings.dart';
import 'package:movie_app/theme/app_theme.dart';
import 'package:movie_app/theme/app_typography.dart';

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({super.key});

  void _getStarted() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/on-boarding.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      welcomText,
                      textStyle: AppTypography.headline1
                          .copyWith(fontWeight: FontWeight.w700),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  welcomContent,
                  style: AppTypography.headline2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _getStarted,
                    style: AppTheme.raisedButtonStyle,
                    child: const Text(
                      getStarted,
                      style: AppTypography.labelMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
