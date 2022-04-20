import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/screens/main_screen/main_screen_content.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  _getPage(int page) {
    switch (page) {
      case 0:
        return MainScreenContent(Constants.homeTabTitle);
      case 1:
        return MainScreenContent(Constants.menuTabTitle);
    }
  }
  _bottomNavigation() {
    return FancyBottomNavigation(
      tabs: [
        TabData(
            iconData: Icons.home,
            title: Constants.homeTabTitle,
            onclick: () {
              _getPage(0);
            }),
        TabData(
            iconData: Icons.menu,
            title: Constants.menuTabTitle,
            onclick: () {
              _getPage(1);
            }),
      ],
      initialSelection: 0,
      key: bottomNavigationKey,
      onTabChangedListener: (position) {
        setState(() {
          currentPage = position;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(currentPage),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

}
