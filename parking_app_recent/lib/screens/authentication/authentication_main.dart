import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/model/users.dart';
import 'package:parking_app/screens/authentication/sign_in.dart';
import 'package:parking_app/screens/authentication/sign_up.dart';
import 'package:parking_app/screens/authentication/social_signup_info.dart';
import 'package:parking_app/screens/main_screen/main_screen.dart';
import 'package:parking_app/services/firebase_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMain extends StatefulWidget {
  @override
  _AuthMainState createState() => _AuthMainState();
}

class _AuthMainState extends State<AuthMain> {
  FirebaseFunctions firebaseFunctions = new FirebaseFunctions();
  final picker = ImagePicker();
  //final dbHelper = DatabaseHelper.instance;
  bool loading = false;
  final imagePicker = ImagePicker();

  // void _openGallery(BuildContext context) async {
  //     XFile? pickedImage =
  //         await imagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     imageFile = pickedFile;
  //   });
  //   Navigator.pop(context);
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png')))),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(
                      20,
                     20,
                      20,
                      20),
                  height:
                      20.h,
                  child: Image.asset("assets/icons/auth.png",
                      fit: BoxFit.contain)),
              Container(
                margin: EdgeInsets.all(10),
                child: Text('Welcome',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 27,
                        fontFamily: Constants.POPPINS,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, right: 45, left: 45),
                child: Text(
                    'Please login or Sign up to continue to the main page.',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              Center(
                child: Container(
                  width: 30.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20.0, right: 20),
                        height: 40,
                        width: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 15.h,
                        margin: EdgeInsets.only(top: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // _signUpButtonLayout(
              //     Functions.getScreenDimension(context, Constants.width))
            ],
          ),
        )
      ],
    ));
  }
}
