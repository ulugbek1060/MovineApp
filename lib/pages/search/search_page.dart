import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/detail/detail_page.dart';
import 'package:movie_app/pages/search/bloc/search_bloc.dart';
import 'package:movie_app/pages/search/widgets/search_bar.dart';
import 'package:movie_app/pages/widgets/movie_item_card.dart';
import 'package:movies_data/movies_data.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const SearchPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(
        repository: RepositoryProvider.of<MoviesRepository>(context),
      ),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView({Key? key}) : super(key: key);

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  late ScrollController _scrollController;
  bool textIsEmpty = true;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  void _submitText(String? value) {
    if (value == null || value.isEmpty) return;
    context.read<SearchBloc>().add(FindMoviesEvent(query: value));
  }

  void _clearInput() {
    context.read<SearchBloc>().add(ClearItemsEvent());
  }

  void _navigate(BuildContext context, String movieId) {
    Navigator.of(context).push(DetailPage.route(movieId));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<SearchBloc>().add(NextPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SearchBar(
          onCleared: _clearInput,
          onSubmitText: _submitText,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          final movies = state.movies;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              itemCount: movies.length,
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 100 / 150,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieItemCard(
                  title: movie.title,
                  rate: movie.rate,
                  posterPath: movie.posterPath,
                  onPressed: () {},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
