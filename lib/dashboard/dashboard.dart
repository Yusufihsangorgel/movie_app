import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:movie_app/dashboard/dashboard_controller.dart';
import 'package:movie_app/navigation/navigation_bar.dart';
import 'package:movie_app/screens/details_screen.dart';
import 'package:movie_app/screens/movie_screen.dart';

class MyDashBoard extends StatefulWidget {
  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [HomeScreen()],
          ),
        ),
        bottomNavigationBar: CustomAnimatedBottomBar(
          containerHeight: 70,
          backgroundColor: Colors.white,
          selectedIndex: controller.tabIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: controller.changeTabIndex,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Ana Sayfa'),
              activeColor: Colors.green,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.chrome_reader_mode_outlined),
              title: Text(
                'Oku',
              ),
              activeColor: Colors.pink,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }

  Widget getBody() {
    List<Widget> pages = [HomeScreen(), DetailsScreen()];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
