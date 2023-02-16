import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/app/bloc/authentication_bloc.dart';
import 'package:movie_app/pages/initialpages/page/welcome_page.dart';
import 'package:movie_app/pages/main/main_page.dart';
import 'package:movie_app/pages/splash/splash_screen.dart';
import 'package:movie_app/theme/app_theme.dart';
import 'package:movies_data/movies_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  final SharedPreferences sharedPref;
  final BoxCollection boxCollection;

  const App({
    super.key,
    required this.sharedPref,
    required this.boxCollection,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthRepository authRepository;
  late final MoviesRepository movieRepository;
  late final StorageRepository storageRepository;

  @override
  void initState() {
    authRepository = AuthRepository(sharedPreferences: widget.sharedPref);
    storageRepository = StorageRepository(boxCollection: widget.boxCollection);
    movieRepository = MoviesRepository();
    super.initState();
  }

  @override
  void dispose() {
    authRepository.dispose();
    storageRepository.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => authRepository),
        RepositoryProvider<StorageRepository>(create: (_) => storageRepository),
        RepositoryProvider<MoviesRepository>(create: (_) => movieRepository),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(authRepository: authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
      themeMode: ThemeMode.system,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.unknown:
                _navigator.pushAndRemoveUntil<void>(
                    SplashPage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                    OnBoardingPage.route(), (route) => false);
                break;
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                    MainPage.route(), (route) => false);
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
