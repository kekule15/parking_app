import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/screens/onboarding/ui_view/slider_layout_view.dart';

import '../../../services/permission_handlers.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    askPermision();
    super.initState();
  }

  askPermision() async {
    await PermissionService().permissionHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() => Container(
        child: SliderLayoutView(),
      );
}
