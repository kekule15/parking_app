import 'package:flutter/material.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/helper/funtions.dart';
import 'package:parking_app/screens/main_screen/menu.dart';
import 'home_screen.dart';

class MainScreenContent extends StatefulWidget {
  final String layoutName;
  MainScreenContent(this.layoutName);
  @override
  _MainScreenContentState createState() => _MainScreenContentState();
}

class _MainScreenContentState extends State<MainScreenContent> {
  _layout(String layoutName) {
    return (layoutName == Constants.homeTabTitle)? HomeScreen(): Menu();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Functions.getScreenDimension(context,Constants.width),
      height:  Functions.getScreenDimension(context,Constants.height),
      child: _layout(widget.layoutName),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
    );
  }


}


