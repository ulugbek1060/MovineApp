import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/explore/filter/filter_view_model.dart';
import 'package:movie_app/pages/widgets/genre_item_widget.dart';
import 'package:movie_app/theme/app_typography.dart';
import 'package:movies_data/movies_data.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late FilterViewModel _filterViewModel;

  MoviesRepository getGenres(BuildContext context) {
    return RepositoryProvider.of<MoviesRepository>(context);
  }

  @override
  void initState() {
    _filterViewModel = FilterViewModel(getGenres(context))..loadGenres();
    super.initState();
  }

  @override
  void dispose() {
    _filterViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: StreamBuilder(
          stream: _filterViewModel.getGenresStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildComponents(snapshot.data!);
            } else {
              return const SizedBox();
            }
          }),
    );
  }

  Widget _buildComponents(FilterState state) {
    switch (state.status) {
      case FilterStatus.success:
        return _GenresList(genres: state.genres);
      case FilterStatus.loading:
        return const _FilterLoading();
      case FilterStatus.error:
        return const _FilterError();
    }
  }
}

class _GenresList extends StatefulWidget {
  const _GenresList({Key? key, required this.genres}) : super(key: key);

  final List<GenreItem> genres;

  @override
  State<_GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<_GenresList> {
  var _selectedGenre;
  var _selectedYear;

  final years = [
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024'
  ];

  @override
  void initState() {
    context.read();
    super.initState();
  }

  void _onReset() {
    context.read();
  }

  void _onApply() {
    context.read();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12.0),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const SizedBox(height: 4.0, width: 50.0),
          ),
          const SizedBox(height: 8.0),
          const Text('Filter', style: AppTypography.headline1),

          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.grey[900]),
          ),
          // genres ---------->
          Container(
              margin: const EdgeInsets.only(left: 20),
              width: double.infinity,
              child: const Text(
                'Genres',
                style: AppTypography.titleLarge,
                textAlign: TextAlign.start,
              )),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = widget.genres[index];
                return GenreItemWidget(
                  selected: _selectedGenre == item.id,
                  genre: item.name,
                  onSelected: () {
                    setState(() {
                      _selectedGenre = item.id;
                    });
                  },
                );
              },
              itemCount: widget.genres.length,
            ),
          ),

          // years ------------->
          const SizedBox(height: 8.0),
          Container(
              margin: const EdgeInsets.only(left: 20),
              width: double.infinity,
              child: const Text(
                'Years',
                style: AppTypography.titleLarge,
                textAlign: TextAlign.start,
              )),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = years[index];
                return GenreItemWidget(
                  selected: _selectedYear == item,
                  genre: item,
                  onSelected: () {
                    setState(() {
                      _selectedYear = item;
                    });
                  },
                );
              },
              itemCount: years.length,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.grey[900]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withAlpha(100),
                    ),
                    onPressed: _onReset,
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Text(
                        'Reset',
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
                    onPressed: _onApply,
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Text(
                        'Apply',
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
      ),
    );
  }
}

class _FilterError extends StatelessWidget {
  const _FilterError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Something went wrong!',
        style: AppTypography.bodyText2,
      ),
    );
  }
}

class _FilterLoading extends StatelessWidget {
  const _FilterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
