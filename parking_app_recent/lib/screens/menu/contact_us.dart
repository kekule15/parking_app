import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  final messageController = TextEditingController();
  final bool enableTextField = true;

  
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blue,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back),
      ),
      title: Text(
        "Contact Us",
        style: TextStyle(),
      ),
    );
  }

  _arrowBack(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
          child: Card(
            elevation: 2,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ));
  }

  _contactFormLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          TextFormField(
            controller: messageController,
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 15,
            enabled: (enableTextField) ? true : false,
            decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: Colors.blue,
                  fontFamily: Constants.OPEN_SANS,
                  fontWeight: FontWeight.w500,
                  // letterSpacing: 1.5,
                  fontSize: 14.5,
                )),
          ),
          SizedBox(
            height:
                20.h
          ),
          InkWell(
            onTap: () async {
              if (messageController.text == '') {
                Constants().notify('Message body is required');
              } else {
                launchEmailSubmission();
              }
            },
            child: Container(
            
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: messageController.text == '' ? Colors.grey : Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Send Message',
                  style: TextStyle(
                      fontFamily: Constants.OPEN_SANS,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 14.5,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void launchEmailSubmission() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'augustusonyekachi111@gmail.com',
        query: 'subject=Message&body=${messageController.text}');
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'))),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(context),
              SizedBox(
                height:
                   20.h
              ),
              Container(
                child: Text(
                  'Would you like to contact us ?',
                  style: TextStyle(
                      fontFamily: Constants.POPPINS,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.5,
                      color: Colors.blue),
                ),
              ),
              SizedBox(
                height:
                   30.h
              ),
              Center(
                child: _contactFormLayout(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
