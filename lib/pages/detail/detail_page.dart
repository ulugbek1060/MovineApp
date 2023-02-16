import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/pages/detail/bloc/detail_movie_bloc.dart';
import 'package:movie_app/pages/detail/widgets/similar_movies_list.dart';
import 'package:movie_app/pages/detail/widgets/videols_list.dart';
import 'package:movie_app/pages/widgets/empty_view.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/progress_view.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_shape.dart';
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

class _DetailView extends StatefulWidget {
  const _DetailView({Key? key, required this.movie, required this.isMarked})
      : super(key: key);

  final MovieDetail movie;
  final bool isMarked;

  @override
  State<_DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<_DetailView>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        SliverAppBar.medium(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          title: Text(
            widget.movie.title,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyLight.send,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            IconButton(
              onPressed: () {
                addToFavorite(context, widget.movie);
              },
              icon: widget.isMarked
                  ? Icon(
                      IconlyBold.bookmark,
                      color: Theme.of(context).colorScheme.onBackground,
                    )
                  : Icon(
                      IconlyLight.bookmark,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
            ),
          ],
        ),
        SliverPaddingContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl: widget.movie.backdropPath,
                placeholder: (context, url) => const ProgressView(),
                errorWidget: (context, url, error) => Icon(
                  IconlyBold.image,
                  size: 100,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverPaddingContainer(
          top: 25,
          left: 20,
          right: 20,
          child: _timeAndRating(
            time: widget.movie.duration,
            rating: widget.movie.rating,
          ),
        ),
        SliverPaddingContainer(
          top: 16,
          left: 20,
          right: 20,
          child: _releaseDateAndGenre(
            releaseDate: widget.movie.releaseData,
            genres: widget.movie.genres,
          ),
        ),
        SliverPaddingContainer(
          top: 16,
          left: 20,
          right: 20,
          child: Text(
            widget.movie.overview,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            TabBar(
              unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
              labelColor: Theme.of(context).colorScheme.secondary,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              controller: _tabController,
              tabs: const [
                Tab(text: 'Videos'),
                Tab(text: 'Similar Movies'),
              ],
            ),
          ),
        ),
        if (_currentIndex == 0)
          const SliverPadding(
            key: ValueKey('videos.1'),
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            sliver: VideosList(),
          ),
        if (_currentIndex == 1)
          const SliverPadding(
            key: ValueKey('movies.1'),
            padding: EdgeInsets.only(
              top: 20,
              left: 8,
              right: 8,
              bottom: 20,
            ),
            sliver: SimilarMoviesList(),
          ),
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
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 10),
        const Icon(IconlyBold.star, color: Colors.amber, size: 18),
        const SizedBox(width: 10),
        Text(
          '$rating (IMDb)',
          style: Theme.of(context).textTheme.bodyMedium,
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
                releaseDate,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  releaseDate,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium,
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
                style: Theme.of(context).textTheme.bodyMedium,
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
                          style: Theme.of(context).textTheme.bodyMedium,
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

class SliverPaddingContainer extends StatelessWidget {
  const SliverPaddingContainer(
      {Key? key,
      this.top = 0.0,
      this.bottom = 0.0,
      this.right = 0.0,
      this.left = 0.0,
      required this.child})
      : super(key: key);

  final double top;
  final double right;
  final double left;
  final double bottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Theme.of(context).colorScheme.background, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
