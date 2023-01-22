import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/movie_screen.dart';
import 'package:movie_app/screens/profile_screen.dart';
import 'package:movie_app/theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = _getBottomNavigation();
    return Scaffold(
      body: screens.values.elementAt(screenIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        currentIndex: screenIndex,
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: screens.keys.toList(),
      ),
    );
  }

  Map<BottomNavigationBarItem, Widget> _getBottomNavigation() {
    final Map<BottomNavigationBarItem, Widget> bottomItems = {
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          width: 18.0,
          'assets/images/home.svg',
          fit: BoxFit.scaleDown,
          color: screenIndex == 0
              ? AppColors.secondaryColor
              : Colors.grey.withAlpha(150),
        ),
        label: 'Home',
      ): const HomeWidget(),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          width: 18.0,
          'assets/images/play.svg',
          fit: BoxFit.scaleDown,
          color: screenIndex == 1
              ? AppColors.secondaryColor
              : Colors.grey.withAlpha(150),
        ),
        label: 'Movies',
      ): const MovieScreen(),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          width: 18.0,
          'assets/images/user.svg',
          fit: BoxFit.scaleDown,
          color: screenIndex == 2
              ? AppColors.secondaryColor
              : Colors.grey.withAlpha(150),
        ),
        label: 'Profile',
      ): const ProfileScreen(),
    };
    return bottomItems;
  }
}
