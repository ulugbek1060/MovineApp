import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/pages/movies/widgets/movies_grid_list.dart';
import 'package:movies_data/movies_data.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  Stream<List<GenreItem>> getActiveGenresStream(BuildContext context) {
    return RepositoryProvider.of<StorageRepository>(context).getActiveGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getActiveGenresStream(context),
      builder: (context, snapshot) {
        return _buildComponent(snapshot);
      },
    );
  }

  Widget _buildComponent(AsyncSnapshot<List<GenreItem>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const _ProgressIndicator();
    } else if (snapshot.hasData) {
      return _MainPage(genres: snapshot.data ?? []);
    } else {
      return const _EmptyPage();
    }
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class _MainPage extends StatelessWidget {
  const _MainPage({Key? key, required this.genres}) : super(key: key);
  final List<GenreItem> genres;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: genres.length,
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              title: const Text('Find Movies'),
              bottom: TabBar(
                isScrollable: true,
                indicator: TabIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                tabs: genres.map((genre) => Tab(text: genre.name)).toList(),
              ),
            )
          ];
        },
        body: TabBarView(
          children:
              genres.map((genre) => MoviesGridView(genreId: genre.id)).toList(),
        ),
      ),
    );
  }
}

class _EmptyPage extends StatelessWidget {
  const _EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TabIndicator extends Decoration {
  const TabIndicator({required this.color});

  final Color color;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return TabPainter(color: color);
  }
}

class TabPainter extends BoxPainter {
  const TabPainter({required this.color});

  final Color color;

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    Paint paint = Paint();
    paint.color = color;
    paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 2.0);
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;

    /*
      print('Height: ${configuration.size!.height}');
      print('Width: ${configuration.size!.width}');
      print('Offset X: ${offset.dx}');
      print('Offset Y: ${offset.dy}');

      flutter : Config Height: 48.0
      flutter : Config Width: 88.0
      flutter : Offset X: 613.0
      flutter : Offset Y: 0.0

      final A = Offset(dx, dy);
      final B = Offset(dx, dy);
                                final rect = Rect.fromPoints(A, B);
                                                                        x = 88
                                                          --------------------------------------
                                                          |                                    |
                                                          |                                    |
                                                          |                                    |
      A                                                 A *----------------------              | y = 48
    y = config.size.height - (config.size.height * 0.1)   |                     |              |
    x = offsetX                                           |          *          |              |
                                                          |        center       |              |
                                                          ----------------------*---------------
                                                                                B
                                                                   B => | y = config.size.height
                                                                        | x = offsetX + (config.size.width / 2)
    */
    final configWidth = configuration.size?.width ?? 1.0;
    final configHeight = configuration.size?.height ?? 1.0;
    final center = Offset(
      (offset.dx + (configWidth / 4) + 5),
      (configHeight - (configHeight * 0.1)),
    );
    var roundedRectangle = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: (configWidth / 2) - 20,
        height: (configHeight * 0.05),
      ),
      const Radius.circular(5.0),
    );
    // final a = Offset(offset.dx + 12, (configHeight - (configHeight * 0.1)));
    // final b = Offset(((configWidth / 2) + offset.dx), configHeight);
    // final rect = Rect.fromPoints(a, b);
    canvas.drawRRect(roundedRectangle, paint);
  }
}
