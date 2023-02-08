import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/onboarding/bloc/register_bloc.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';

final genres = [
  'Action',
  'Drama',
  'Comedy',
  'Horror',
  'Adventure',
  'Thriller',
  'Romance',
  'Crime',
  'Fantasy',
  'Documentary',
  'Mystery',
  'Fiction',
  'History',
  'Animation',
  'Television',
  'Anime',
  'Sports',
  'K-Drama'
];

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
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
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
                      style: AppTypography.bodyText1,
                      'Choose your interests and get the best movie recommendations. Don\'t worry, you can always change it later.'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: state.genres
                          .map(
                            (e) => _GenreItem(
                              genre: e.name,
                              selected: e.isSelected,
                              onSelected: () {
                                context.read<RegisterBloc>().add(ChangeFlagEvent(e));
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Container(
                            margin: const EdgeInsets.all(2.0),
                            child: Text(
                              'Skip',
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
                          onPressed: () {},
                          child: Container(
                            margin: const EdgeInsets.all(2.0),
                            child: Text(
                              'Continue',
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
        ),
      ),
    );
  }
}

class _GenreItem extends StatelessWidget {
  final String genre;
  final bool selected;
  final void Function() onSelected;

  const _GenreItem({
    Key? key,
    required this.genre,
    this.selected = false,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger('genre_items: $genre -> $selected');
    return InkWell(
      onTap: onSelected,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
          border: Border.all(
            width: 2,
            color: AppColors.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(30),
          // gradient: AppColors.gradient,
        ),
        child: Text(
          genre,
          style: AppTypography.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
            color: selected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
