import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/model/users.dart';
import 'package:parking_app/screens/authentication/model.dart';
import 'package:parking_app/screens/main_screen/main_screen.dart';
import 'package:parking_app/services/firebase_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseFunctions firebaseFunctions = new FirebaseFunctions();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final picker = ImagePicker();
  // final dbHelper = DatabaseHelper.instance;
  bool loading = false, enableTextFields = true;
  //PickedFile imageFile;
  final _formKey = GlobalKey<FormState>();

  // void _openGallery(BuildContext context) async {
  //   final pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //   );
  //   setState(() {
  //     imageFile = pickedFile;
  //   });
  //   final User user = _auth.currentUser;
  //   final _uid = user.uid;
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('Images')
  //       .child('image-${Timestamp.now().millisecondsSinceEpoch.toString()}')
  //       .child('$_uid');
  //   await ref.putFile(File(imageFile.path.toString()));
  //   imageUrl = await ref.getDownloadURL();

  //   var documentReference = FirebaseFirestore.instance
  //       .collection('usersImage')
  //       .doc(_uid)
  //       .collection('userimageFile')
  //       .doc(DateTime.now().millisecondsSinceEpoch.toString());
  // }

  _signUpFormLayout() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              // ignore: missing_return
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Field is required';
                // }
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.blueAccent,
                  ),
                  hintText: 'Name',
                  hintStyle: TextStyle(
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
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[ ]')),
              ],
              controller: phoneNumberController,
              // ignore: missing_return
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Field is required';
                // }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blueAccent,
                  ),
                  hintText: 'Your Number',
                  hintStyle: TextStyle(
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
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[ ]')),
              ],
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              // ignore: missing_return
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Field is required';
                // }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blueAccent,
                  ),
                  hintText: 'Your Email',
                  hintStyle: TextStyle(
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
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[ ]')),
              ],
              controller: passwordController,
              // ignore: missing_return
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Field is required';
                // }
              },
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.security,
                    color: Colors.blueAccent,
                  ),
                  hintText: 'Your password',
                  hintStyle: TextStyle(
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
                signUp(emailController.text, passwordController.text);
              },
              child: Container(
              
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: Center(
                  child: (loading)
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : Text(
                          'Sign Up',
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
      ),
    );
  }

  //-----

  _content() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Get a safe Parking space',
                style: TextStyle(
                  fontFamily: Constants.POPPINS,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.5,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              child: Text(
                'Getting a parking space has not been this easy.Login and lets explore the parking spaces in the neighbourhood.',
                style: TextStyle(
                  fontFamily: Constants.OPEN_SANS,
                  fontWeight: FontWeight.w500,
                  // letterSpacing: 1.5,
                  fontSize: 14.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height:
                  20.h
            ),
            InkWell(
              onTap: () {
                //  _openGallery(context);
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                // backgroundImage: imageFile == null
                //     ? AssetImage('assets/images/faq_background.png')
                //     : FileImage(File(imageFile.path)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Profile Image'),
            SizedBox(
              height: 10,
            ),
            _signUpFormLayout()
            // _signUpButtonLayout(_screenHeight)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: [
        SizedBox.expand(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Center(
          child: _content(),
        )
      ],
    )));
  }

  //String imageUrl;

  void signUp(String email, String password) async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          setState(() {
            loading = false;
          });
          Fluttertoast.showToast(msg: e.message);
        });
      } on FirebaseAuthException catch (error) {
        setState(() {
          loading = false;
        });
        switch (error.code) {
          case "invalid-email":
            Fluttertoast.showToast(
                msg: "Your email address appears to be malformed ");
            break;
          case "wrong-password":
            Fluttertoast.showToast(msg: "Your password is wrong ");
            break;
          case "user-not-found":
            Fluttertoast.showToast(msg: "User with this email doesn't exist.");

            break;
          case "user-disabled":
            Fluttertoast.showToast(
                msg: "User with this email has been disabled.");

            break;

          default:
            Fluttertoast.showToast(msg: "An undefined Error happened.");
        }
        print(error.code);
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModeltwo userModel = UserModeltwo(
      uid: user!.uid,
      email: user.email,
      name: nameController.text,
      image: '',
    );

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final login = prefs.setString('login', 'token');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (route) => false);
  }
}
