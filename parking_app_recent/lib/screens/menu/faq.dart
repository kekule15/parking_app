import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
class Faq extends StatelessWidget {
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.withOpacity(1),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),

      ),
      title: Text(
        "Frequently Asked Question",
        style: TextStyle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.blue,
      body: Container(
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/faq_background.png')
        //   )
        // ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 20),
                height:
                40.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/faq.png"),
                        fit: BoxFit.contain)),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "FAQ",
                  style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
             
              
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                decoration: BoxDecoration(
                    color: Colors.white60.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ExpansionTile(
                  leading: Icon(
                      Icons.info_outlined,
                      color: Colors.amber
                  ),
                  title: Text(
                    "What is Parkify",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.arrow_forward,size: 15,color: Colors.blueAccent,),
                      title: Text(
                          'This is a mobile app designed to ease your parking experience.It discovers the vacant parking spaces around you.',
                          style:
                          TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
