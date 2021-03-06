import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:movie_app/dashboard/dashboard_controller.dart';
import 'package:movie_app/navigation/navigation_bar.dart';
import 'package:movie_app/screens/favorites_screen.dart';
import 'package:movie_app/screens/name_search_screen.dart';
import 'package:movie_app/screens/movie_screen.dart';

class MyDashBoard extends StatelessWidget {
  const MyDashBoard({Key? key}) : super(key: key);

  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex.value,
            children: [
              MovieScreen(),
              const NameSearchScreen(),
              const FavoritesScreen()
            ],
          ),
        ),
        bottomNavigationBar: CustomAnimatedBottomBar(
          containerHeight: 70,
          backgroundColor: Colors.white,
          selectedIndex: controller.tabIndex.value,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: controller.changeTabIndex,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.movie),
              title: const Text('Movies'),
              activeColor: Colors.red,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.search),
              title: const Text(
                'Search',
              ),
              activeColor: Colors.green,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.favorite),
              title: const Text('Settings'),
              activeColor: Colors.blue,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }

  Widget getBody() {
    List<Widget> pages = [
      MovieScreen(),
      const NameSearchScreen(),
      const FavoritesScreen()
    ];
    return IndexedStack(
      index: 0,
      children: pages,
    );
  }
}
