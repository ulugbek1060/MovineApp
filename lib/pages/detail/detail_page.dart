import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/detail/widgets/similar_movies_list.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_shape.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';

class DetailPage extends StatelessWidget {
  final String movieId;

  static Route<void> route(String movieId) =>
      MaterialPageRoute(builder: (_) => DetailPage(movieId: movieId));

  const DetailPage({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  MoviesRepository repository(BuildContext context) =>
      RepositoryProvider.of<MoviesRepository>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
        create: (_) => DetailMovieBloc(
          moviesRepository: repository(context),
        )..add(FetchedMovieDetailEvent(movieId: movieId)),
        child: const MovieDetailView(),
      ),
    );
  }
}

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({Key? key}) : super(key: key);

  void navigate(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        final movie = state.movie;

        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ),
          );
        }
        if (state.error != null && movie == null) {
          return Container(
            child: Text('Fail'),
          );
        }

        // movie must not be null
        if (movie != null) {
          return CustomScrollView(
            slivers: [
              CustomSliverAppbar(movie: movie),
              SliverPaddingContainer(
                top: 25,
                left: 20,
                right: 20,
                bottom: 0,
                child: _timeAndRating(
                  time: movie.duration,
                  rating: movie.rating,
                ),
              ),
              SliverPaddingContainer(
                top: 16,
                left: 20,
                right: 20,
                bottom: 0,
                child: _releaseDateAndGenre(
                  releaseDate: movie.releaseData,
                  genres: movie.genres,
                ),
              ),
              SliverPaddingContainer(
                top: 16,
                left: 20,
                right: 20,
                bottom: 0,
                child: Text(
                  movie.overview,
                  style: AppTypography.bodyText2.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              SliverPaddingContainer(
                top: 8,
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: 200,
                  child: SimilarMoviesList(
                    size: 200,
                    navigate: (movieId) {
                      navigate(context, movieId);
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _timeAndRating({
    required String time,
    required String rating,
  }) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/ic-time.svg'),
        const SizedBox(width: 10),
        Text(
          '$time minutes',
          style: AppTypography.bodyText2,
        ),
        const SizedBox(width: 10),
        SvgPicture.asset('assets/images/ic-star.svg'),
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
    String releaseDate = '',
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
              SizedBox(
                child: Wrap(
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
              )
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
    this.top = 16,
    this.right = 16,
    this.bottom = 16,
    this.left = 16,
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

class CustomSliverAppbar extends SliverAppBar {
  final MovieDetail movie;

  CustomSliverAppbar({super.key, required this.movie})
      : super(
          expandedHeight: 300,
          pinned: true,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [Colors.teal[800]!, Colors.transparent]),
              ),
              child: Image.network(movie.poserPath, fit: BoxFit.cover),
            ),
            centerTitle: false,
            titlePadding: const EdgeInsets.all(12),
            title: Text(movie.title, overflow: TextOverflow.ellipsis),
          ),
        );
}
