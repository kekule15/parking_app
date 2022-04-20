import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
      title: Text(
        "Privacy Policy",
        style: TextStyle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: Container(
          height: double.infinity,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('assets/images/faq_background.png')
          //     )
          // ),
        )
    );
  }
}
