import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/helper/funtions.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.withOpacity(1),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
      title: Text(
        "About Us",
        style: TextStyle(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.blue,
      body: Container(
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/faq_background.png')
        //   )
        // ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Parkify",
                    style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "version 1.0.0",
                    style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                      top: Functions
                          .getScreenDimension(context, Constants.height) *
                          .005),
                  height:
                  Functions.getScreenDimension(context, Constants.height) *
                      .4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/slider3.png"),
                          fit: BoxFit.contain)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
