

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingState = StateProvider.autoDispose<bool>((ref) => false);

final contentErrorState = StateProvider.autoDispose<String>((ref) => '');
final errorState = StateProvider.autoDispose<String>((ref) => '');
final pinErrorState = StateProvider.autoDispose<String>((ref) => '');

final snackBarKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>(
    (ref) => GlobalKey<ScaffoldMessengerState>());
