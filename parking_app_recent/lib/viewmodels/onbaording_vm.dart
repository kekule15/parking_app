
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingViewModel extends ChangeNotifier {
  final Ref ref;

  OnBoardingViewModel(this.ref);

  List<Map<String, dynamic>> onboardingvalue() {
  
    return [
      {
        "title": "Pay for friends with just a few taps",
        "subtitle": "Make Instant bill payments to  friends and families wherever they are.",
        "icon": ''
      },
       {
        "title": "Pay and get paid any way you want",
        "subtitle": "Send payment links or flash QR codes, and tell your friends to Dash me!",
        "icon": ''
      },
       {
        "title": "Reach your financial goals effortlessly",
        "subtitle":  "Put money aside effortlessly for those rainy days, vacation, birthday or for that special cause.",
        "icon": ''
      },
       {
        "title": "Organize your bills with LesPay",
        "subtitle":  "Set up your bills on LesPay automatically so you'll never miss a moment.",
        "icon": ''
      },
       {
        "title": "Never OverSpend again with smart budgeting",
        "subtitle":  "Take control of your money with smart budgeting and analytics tools.",
        "icon": ''
      },
     
      
    ];
  }
}
