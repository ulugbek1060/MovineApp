import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/movie_screen.dart';
import 'package:movie_app/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var page = 0;

  final Map<BottomNavigationBarItem, Widget> bottomItems = const {
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ): HomeWidget(),
    BottomNavigationBarItem(
      icon: Icon(Icons.play_arrow),
      label: 'Movies',
    ): MovieScreen(),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ): ProfileScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomItems.values.elementAt(page),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: bottomItems.keys.toList(),
      ),
    );
  }
}
