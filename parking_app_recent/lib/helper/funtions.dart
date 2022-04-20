import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Functions{
  static double getScreenDimension(BuildContext context,String dimensionType){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return (dimensionType == 'width')? width :height;
  }

  static SnackBar customSnackBar({String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  void getSubscriptionDaysLeft(String expiryDateString){
    DateTime expiryDate = DateTime.parse(expiryDateString);
    DateTime today = DateTime.now();
    var daysLeft = expiryDate.difference(today).inDays;
    print('daysleft: ${ (daysLeft < 0) ? '0' : daysLeft}');
    // print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
  }

}
