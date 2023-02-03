import 'package:flutter/material.dart';
import 'package:movie_app/pages/movies/widgets/movies_page_view.dart';
import 'package:movies_data/movies_data.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List<MovieType> types;

  @override
  void initState() {
    types = [
      MovieType.NOW_PLAYING,
      MovieType.UPCOMING,
      MovieType.POPULAR,
      MovieType.TOP_RATED,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: types.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: _MoviesNestedScrollView(types: types),
      ),
    );
  }
}

class _MoviesNestedScrollView extends StatelessWidget {
  final List<MovieType> types;

  const _MoviesNestedScrollView({
    Key? key,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
            title: const Text('Find Movies'),
            bottom: _getTabs(context: context),
          )
        ];
      },
      body: MoviesPageView(types: types),
    );
  }

  PreferredSizeWidget _getTabs({required BuildContext context}) {
    return TabBar(
      isScrollable: true,
      indicator: TabIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
      tabs: types
          .map((type) => Tab(
                text: type.getTypeText,
              ))
          .toList(),
    );
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
                                                          |        cneter       |              |
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
