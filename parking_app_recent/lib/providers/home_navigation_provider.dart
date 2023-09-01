
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/viewmodels/home_vm.dart';

final homeViewModel =
    ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel(ref));



    
final snackBarKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>(
    (ref) => GlobalKey<ScaffoldMessengerState>());
