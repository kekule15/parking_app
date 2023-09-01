// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';

class HomeViewModel extends ChangeNotifier {
  int selectedIndex = 0;
  final Ref ref;
  HomeViewModel(this.ref);

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  bool stateValue = true;

  void changeStateValue() {
    log("message $stateValue");
    stateValue = false;
    notifyListeners();
  }

  void changeStateValueToFalse() {
    log("message $stateValue");
    stateValue = true;
    notifyListeners();
  }


}
