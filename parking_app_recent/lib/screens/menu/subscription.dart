import 'package:flutter/material.dart';
import 'package:parking_app/style/appColors.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
      title: Text(
        "Subscription",
        style: TextStyle(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.primary,
      appBar: _appBar(context),
      body:Container(
        height: double.infinity,
        color:  AppColors.primary,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/images/faq_background.png')
        //     )
        // ),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}