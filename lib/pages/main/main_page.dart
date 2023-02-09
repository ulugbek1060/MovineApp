import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_app/pages/favorites/favorites_page.dart';
import 'package:movie_app/pages/home/home_page.dart';
import 'package:movie_app/pages/profile/profile_screen.dart';
import 'package:movie_app/utils/strings.dart';

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
    const HomePage(),
    Container(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  void _setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: _selectedIndex,
        onTap: _setIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const Icon(IconlyBold.home)
                : const Icon(IconlyLight.home),
            label: home,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(IconlyBold.discovery)
                : const Icon(IconlyLight.discovery),
            label: explore,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(IconlyBold.bookmark)
                : const Icon(IconlyLight.bookmark),
            label: myList,
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(IconlyBold.user_2)
                : const Icon(IconlyLight.user),
            label: profile,
          )
        ],
      ),
    );
  }
}
