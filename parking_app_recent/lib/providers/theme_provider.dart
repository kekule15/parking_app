
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/style/theme.dart';

final themeDataProvider = ChangeNotifierProvider<ThemeProvider>(
    (ref) => ThemeProvider());
