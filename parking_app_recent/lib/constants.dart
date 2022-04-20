import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Constants{

  static String appName = "Parking App";
  static String height = 'height';
  static String width = 'width';

  static String homeTabTitle = 'Home';
  static String menuTabTitle = 'Menu';

  static double cardHeight = 200;
  static double listHeight = 120;
  static double padding = 10;
  static double borderRadius = 10;
  static double cardElevation = 8;
  static double borderSideWidth = 1;
  static double opacity = 0.6;
  static double fontSize = 12;
  static double listTileWidth = 50;
  static double listTileHeight = 100;
  static double listTitleFontSize = 18;

  static String apiKey = 'AIzaSyCxDNXXf3xCX6I2Gzxy6hd75w_NSXoCKhY';
  //Akins key
  //'AIzaSyCg-UsEyTaGhqKAkRA_y6ecQbyxSzJqaZI';
  static String exceptionError = "Unable to perform request!";
  static const homePageFacebookButtonText = "Continue With Facebook";
  static const homePageGoogleButtonText = "Continue With Google";

  static const String POPPINS = "Poppins";
  static const String OPEN_SANS = "OpenSans";
  static const String SKIP = "Skip";
  static const String NEXT = "Next";
  static const String SLIDER_HEADING_1 = "Seamless Parking!";
  static const String SLIDER_HEADING_2 = "Great User Experience";
  static const String SLIDER_HEADING_3 = "Nearest Spots on your palm";
  static const String SLIDER_DESC_1 = "With this app, you can locate some vacant parking spaces effortlessly with few taps.";
  static const String SLIDER_DESC_2 = "This app has been designed to give you optimum user experience and hassle-free usage.";
  static const String SLIDER_DESC_3 = "We dont just fetch parking spaces, we look for the closest to you to easy your parking experience.";

  Future notify(String msg) async {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}