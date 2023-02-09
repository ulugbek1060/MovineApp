import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/initialpages/bloc/register_bloc.dart';
import 'package:movie_app/pages/initialpages/widgets/genre_item_widget.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/utils/strings.dart';
import 'package:movies_data/movies_data.dart';

class GenresSelectionPage extends StatelessWidget {
  const GenresSelectionPage({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const GenresSelectionPage());

  AuthRepository authRepository(BuildContext context) =>
      RepositoryProvider.of<AuthRepository>(context);

  StorageRepository storageRepository(BuildContext context) =>
      RepositoryProvider.of<StorageRepository>(context);

  MoviesRepository moviesRepository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Chose Your Interests'),
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (_) => RegisterBloc(
          authRepository: authRepository(context),
          moviesRepository: moviesRepository(context),
          storageRepository: storageRepository(context),
        )..add(const FetchGenresEvent()),
        child: const _MainView(),
      ),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView({Key? key}) : super(key: key);

  void genreSelection(BuildContext context, GenreItem genre) {
    context.read<RegisterBloc>().add(ChangeFlagEvent(genre));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        }
        if (state.error != null) {
          return Center(
            child: Text(
              state.error.toString(),
              style: AppTypography.titleLarge,
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(12.0),
              child: const Text(
                  style: AppTypography.bodyText1, choseFavoriteGenre),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: state.genres
                      .map((item) => GenreItemWidget(
                          selected: item.isSelected,
                          genre: item.name,
                          onSelected: () {
                            genreSelection(context, item);
                          }))
                      .toList(),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: null,
                      child: Container(
                        margin: const EdgeInsets.all(2.0),
                        child: Text(
                          skip,
                          style: AppTypography.bodyText1.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<RegisterBloc>().add(FinishRegisterEvent());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(2.0),
                        child: Text(
                          continui,
                          style: AppTypography.bodyText1.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
