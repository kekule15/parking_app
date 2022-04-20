import 'package:flutter/material.dart';
import 'package:parking_app/screens/main_screen/main_screen.dart';
import 'package:parking_app/screens/onboarding/screens/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/authentication_main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _transitionToNextPageAfterSplash();
    super.initState();
  }

  _transitionToNextPageAfterSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login');
    final onboard = prefs.getString('onboard');
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> login == null && onboard == null
            ? OnboardingPage()
            : login == null && onboard != null
                ? AuthMain()
                : MainScreen()), (route) => false);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return login == null && onboard == null
      //       ? OnboardingPage()
      //       : login == null && onboard != null
      //           ? AuthMain
      //           : MainScreen();
      // }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset('assets/icons/slider3.png'),
      ),
    );
  }
}
