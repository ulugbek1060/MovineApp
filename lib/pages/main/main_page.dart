import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/pages/home/home_screen.dart';
import 'package:movie_app/pages/movies/movies_page.dart';
import 'package:movie_app/pages/profile/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const MainPage());
  }
}

class _MainPageState extends State<MainPage> {
  var _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeWidget(),
    const MoviesPage(),
    const ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.play),
      label: 'Movies',
    ),
    const BottomNavigationBarItem(
      icon: Icon(IconlyBold.user_2),
      label: 'Profile',
    )
  ];

  void _setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: _selectedIndex,
        onTap: _setIndex,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _bottomItems,
      ),
    );
  }
}
