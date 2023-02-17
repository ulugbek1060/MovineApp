import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/widgets/error_view.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movie_app/theme/app_colors.dart';
import 'package:movie_app/utils/slive_grid_delegate.dart';
import 'package:movies_data/movies_data.dart';

class MoviesGridView extends StatefulWidget {
  final String genreId;

  const MoviesGridView({Key? key, required this.genreId}) : super(key: key);

  @override
  State<MoviesGridView> createState() => _MoviesGridViewState();
}

class _MoviesGridViewState extends State<MoviesGridView> {
  static const _pageSize = 20;
  late PagingController<int, MovieItem> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final repository = RepositoryProvider.of<MoviesRepository>(context);

      final result = await repository.discoverMovies(
        page: pageKey,
        genreId: widget.genreId,
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
        color: Theme.of(context).colorScheme.onPrimary,
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedGridView<int, MovieItem>(
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          gridDelegate:  gridDelegate(context),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieItem>(
            itemBuilder: (context, movie, index) => MovieItemCard(movie: movie),
            firstPageErrorIndicatorBuilder: (_) => ErrorView(
              message: _pagingController.error,
              onRetry: () => _pagingController.refresh(),
            ),
            newPageErrorIndicatorBuilder: (_) => ErrorView(
              message: _pagingController.error,
              onRetry: () => _pagingController.refresh(),
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
