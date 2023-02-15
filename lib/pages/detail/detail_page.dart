import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/detail/widgets/similar_movies_list.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_shape.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movie_app/utils/status.dart';
import 'package:movies_data/movies_data.dart';

class DetailPage extends StatelessWidget {
  final String movieId;

  static Route<void> route(String movieId) =>
      MaterialPageRoute(builder: (_) => DetailPage(movieId: movieId));

  const DetailPage({Key? key, required this.movieId}) : super(key: key);

  MoviesRepository movieRepository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  StorageRepository storageRepository(BuildContext context) =>
      RepositoryProvider.of<StorageRepository>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
        create: (_) => DetailMovieBloc(
          moviesRepository: movieRepository(context),
          storageRepository: storageRepository(context),
        )..add(FetchedMovieEvent(movieId: movieId)),
        child: MovieDetailView(onRetry: () {
          context
              .read<DetailMovieBloc>()
              .add(FetchedMovieEvent(movieId: movieId));
        }),
      ),
    );
  }
}

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({Key? key, required this.onRetry}) : super(key: key);

  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        return _buildComponents(state);
      },
    );
  }

  Widget _buildComponents(DetailMovieState state) {
    switch (state.status) {
      case Status.success:
        return _DetailView(movie: state.movie!, isMarked: state.isMarked);
      case Status.pending:
        return const ProgressView();
      case Status.empty:
        return const EmptyView();
      case Status.error:
        return ErrorView(onRetry: onRetry);
    }
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({Key? key, required this.movie, required this.isMarked})
      : super(key: key);

  final MovieDetail movie;
  final bool isMarked;

  void navigate(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
  }

  void addToFavorite(BuildContext context, MovieDetail movie) {
    context.read<DetailMovieBloc>().add(BookmarkEvent(
        item: MovieItem(
            id: movie.id,
            title: movie.title,
            rate: movie.rating,
            posterPath: movie.poserPath,
            backdropPath: movie.backdropPath)));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          movie: movie,
          actions: [
            IconButton(
              onPressed: () {
                addToFavorite(context, movie);
              },
              icon: isMarked
                  ? const Icon(IconlyBold.bookmark)
                  : const Icon(IconlyLight.bookmark),
            )
          ],
        ),
        SliverPaddingContainer(
          top: 25,
          left: 20,
          right: 20,
          child: _timeAndRating(
            time: movie.duration,
            rating: movie.rating,
          ),
        ),
        SliverPaddingContainer(
          top: 16,
          left: 20,
          right: 20,
          child: _releaseDateAndGenre(
            releaseDate: movie.releaseData,
            genres: movie.genres,
          ),
        ),
        SliverPaddingContainer(
          top: 16,
          left: 20,
          right: 20,
          child: Text(
            movie.overview,
            style: AppTypography.bodyText2.copyWith(
              fontSize: 14,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          sliver: SimilarMoviesList(
            navigate: (movieId) {
              navigate(context, movieId);
            },
          ),
        )
      ],
    );
  }

  Widget _timeAndRating({
    required String time,
    required String rating,
  }) {
    return Row(
      children: [
        const Icon(IconlyBold.time_circle, color: Colors.blue, size: 18),
        const SizedBox(width: 10),
        Text(
          '$time minutes',
          style: AppTypography.bodyText2,
        ),
        const SizedBox(width: 10),
        const Icon(IconlyBold.star, color: Colors.amber, size: 18),
        const SizedBox(width: 10),
        Text(
          '$rating (IMDb)',
          style: AppTypography.bodyText2,
        ),
      ],
    );
  }

  Widget _releaseDateAndGenre({
    required List<String> genres,
    required String releaseDate,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Release Date section
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Release date: ',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  releaseDate,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTypography.bodyText2.copyWith(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 5),

          // Genre section
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Genre',
                style: AppTypography.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                runAlignment: WrapAlignment.end,
                children: genres
                    .map(
                      (text) => Container(
                        // margin: const EdgeInsets.only(top: 4, right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withAlpha(20),
                          ),
                          borderRadius:
                              BorderRadius.circular(AppShape.normalShaper),
                          gradient: AppColors.gradient,
                        ),
                        child: Text(
                          text,
                          style: AppTypography.bodyText1,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SliverPaddingContainer extends SliverToBoxAdapter {
  final double top;
  final double right;
  final double left;
  final double bottom;

  SliverPaddingContainer({
    super.key,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
    required Widget child,
  }) : super(
          child: Padding(
            padding: EdgeInsets.only(
              top: top,
              left: left,
              right: right,
              bottom: bottom,
            ),
            child: child,
          ),
        );
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar(
      {Key? key, required this.movie, required this.actions})
      : super(key: key);

  final MovieDetail movie;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(IconlyLight.arrow_left_2),
      ),
      expandedHeight: 300,
      pinned: true,
      elevation: 0,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [AppColors.primaryColor, Colors.transparent]),
          ),
          child: CachedNetworkImage(
            imageUrl: movie.backdropPath,
            placeholder: (context, url) => const ProgressView(),
            errorWidget: (context, url, error) => Icon(
              IconlyBold.image,
              size: 100,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            fit: BoxFit.cover,
          ),
        ),
        centerTitle: true,
        title: Text(movie.title, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
