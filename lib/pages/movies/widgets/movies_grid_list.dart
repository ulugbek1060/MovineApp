import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/widgets/movie_grid_item.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';

class MoviesGridView extends StatefulWidget {
  final MovieType type;

  const MoviesGridView({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<MoviesGridView> createState() => _MoviesGridViewState();
}

class _MoviesGridViewState extends State<MoviesGridView> {
  static const _pageSize = 20;
  final PagingController<int, MovieItem> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // await Future.delayed(const Duration(seconds: 3));
      // throw Exception('not Found dsdsdsdd');

      final repository = RepositoryProvider.of<MoviesRepository>(context);

      final result = await repository.getMoviesByType(
        page: pageKey,
        type: widget.type,
      );

      final movies = result.movies ?? [];
      final isLastPage = movies.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(movies);
      } else {
        final nextPageKey = (result.page ?? pageKey) + 1;
        _pagingController.appendPage(movies, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void navigate(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedGridView<int, MovieItem>(
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 100 / 150,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
          ),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieItem>(
            itemBuilder: (context, movie, index) => MovieGridItem(
              key: Key(movie.id),
              onTap: () {
                navigate(context, movie.id);
              },
              movie: movie,
            ),
            firstPageErrorIndicatorBuilder: (_) => _FirstPageErrorIndicator(
              error: _pagingController.error,
              onTryAgain: () => _pagingController.refresh(),
            ),
            newPageErrorIndicatorBuilder: (_) => _FirstPageErrorIndicator(
              error: _pagingController.error,
              onTryAgain: () => _pagingController.retryLastFailedRequest(),
            ),
            firstPageProgressIndicatorBuilder: (_) => Container(
              margin: const EdgeInsets.all(16),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            newPageProgressIndicatorBuilder: (_) => Container(
              margin: const EdgeInsets.all(16),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            // noItemsFoundIndicatorBuilder: (_) => NoItemsFoundIndicator(),
            // noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(),
          ),
        ),
      );
}

class _NewPageErrorIndicator {}

class _FirstPageErrorIndicator extends StatelessWidget {
  final Object error;
  final void Function() onTryAgain;

  const _FirstPageErrorIndicator({
    required this.error,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: Text(
              '$error',
              style: AppTypography.bodyText2,
            ),
          ),
          ElevatedButton(onPressed: onTryAgain, child: const Text('Tyr again')),
        ],
      ),
    );
  }
}
