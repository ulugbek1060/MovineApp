import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/screens/movies_list_widget.dart';
import 'package:movie_app/theme/app_typography.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late TabController _tabController;

  final Map<Tab, Widget> tabs = {
    const Tab(text: 'Lates'): const MoviesListWidget(moviesType: 'Lates'),
    const Tab(text: 'Now Playing'):
        const MoviesListWidget(moviesType: 'Now Playing'),
    const Tab(text: 'Upcoming'): const MoviesListWidget(moviesType: 'Upcoming'),
    const Tab(text: 'Popular'): const MoviesListWidget(moviesType: 'Popular'),
    const Tab(text: 'Top Rate'): const MoviesListWidget(moviesType: 'Top Rate')
  };

  @override
  void initState() {
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height - mediaQuery.padding.top - 70;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.03,
              ),
              child: const Text(
                'Top Movies Everywhere',
                style: AppTypography.titleLarge,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: TextField(
                controller: _searchController,
                style: AppTypography.labelMedium,
                cursorColor: Colors.white.withOpacity(0.2),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(4),
                  fillColor: theme.colorScheme.surface,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintStyle: AppTypography.labelMedium.copyWith(
                    color: Colors.grey,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset('assets/images/ic-search.svg'),
                  ),
                  hintText: 'Search...',
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            TabBar(
              isScrollable: true,
              controller: _tabController,
              indicator: TabIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
              labelColor: Theme.of(context).colorScheme.secondary,
              unselectedLabelColor: Colors.white.withOpacity(0.8),
              tabs: tabs.keys.toList(),
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs.values.toList(),
              ),
            ),
          ],
        ),
      ),
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
