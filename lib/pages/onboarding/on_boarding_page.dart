import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/onboarding/bloc/register_bloc.dart';
import 'package:movie_app/utils/strings.dart';
import 'package:movie_app/theme/app_theme.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const OnBoardingPage());
  }

  AuthRepository authRepository(BuildContext context) =>
      RepositoryProvider.of<AuthRepository>(context);

  StorageRepository storageRepository(BuildContext context) =>
      RepositoryProvider.of<StorageRepository>(context);

  MoviesRepository moviesRepository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RegisterBloc(
          authRepository: authRepository(context),
          moviesRepository: moviesRepository(context),
          storageRepository: storageRepository(context),
        ),
        child: _OnBoardingView(),
      ),
    );
  }
}

class _OnBoardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            _welcomeText(),
            const SizedBox(height: 10),
            _content(),
            const SizedBox(height: 30),
            _submitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _welcomeText() {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TypewriterAnimatedText(
          welcomeText,
          textStyle:
              AppTypography.headline1.copyWith(fontWeight: FontWeight.w700),
          speed: const Duration(milliseconds: 100),
        ),
      ],
    );
  }

  Widget _content() {
    return const Text(
      welcomeContent,
      style: AppTypography.headline2,
      textAlign: TextAlign.center,
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<RegisterBloc>().add(FinishRegisterEvent());
        },
        style: AppTheme.raisedButtonStyle,
        child: const Text(
          getStarted,
          style: AppTypography.labelMedium,
        ),
      ),
    );
  }
}
