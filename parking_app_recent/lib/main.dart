import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/screens/splash.dart';
import 'package:parking_app/services/geolocator_service.dart';
import 'package:parking_app/services/places_service.dart';
import 'package:provider/provider.dart';

void main() async {

   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final locationService = GeoLocatorService();
  final placeService = PlaceService();

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => locationService.getLocation(),
          catchError: (context, error) {},
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Splash()), // MainScreen())
    );
  }
}
