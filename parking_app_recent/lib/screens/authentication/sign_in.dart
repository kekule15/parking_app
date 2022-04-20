import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/helper/db_helper.dart';
import 'package:parking_app/helper/funtions.dart';
import 'package:parking_app/model/users.dart';
import 'package:parking_app/screens/authentication/social_signup_info.dart';
import 'package:parking_app/screens/main_screen/main_screen.dart';
import 'package:parking_app/services/firebase_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseFunctions firebaseFunctions = new FirebaseFunctions();
  final picker = ImagePicker();
  final dbHelper = DatabaseHelper.instance;
  bool loading = false, enableTextFields = true;
  PickedFile imageFile;
  final _formKey = GlobalKey<FormState>();

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  _loginFormLayout() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field is required';
                }
              },
               inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check),
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
                  Functions.getScreenDimension(context, Constants.height) * .02,
            ),
            TextFormField(
              controller: passwordController,
               inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],

              keyboardType: TextInputType.visiblePassword,
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'Field is required';
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.security),
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
                  Functions.getScreenDimension(context, Constants.height) * .05,
            ),
            InkWell(
              onTap: () async {
                signIn();
              },
              child: Container(
                width: Functions.getScreenDimension(context, Constants.width) *
                    0.6,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: Center(
                  child: loading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Login',
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
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: Functions.getScreenDimension(context, Constants.height) *
                      .06),
              height:
                  Functions.getScreenDimension(context, Constants.height) * .4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/login.png"),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              height:
                  Functions.getScreenDimension(context, Constants.height) * .02,
            ),
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
              height: Functions.getScreenDimension(context, Constants.height) *
                  .012,
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
                  Functions.getScreenDimension(context, Constants.height) * .07,
            ),
            _loginFormLayout()
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
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png')))),
          _content()
        ],
      )),
    );
  }

  Future signIn() async {
    setState(() {
      loading = true;
    });
    final form = _formKey.currentState;
    if (!form.validate()) {
      setState(() {
        loading = false;
      });
    } else {
      form.save();

      UserModel userModel = await firebaseFunctions
          .signInUsingEmailAndPassword(
              emailController.text, passwordController.text)
          .catchError((error) {
        setState(() {
          loading = false;
        });
        Constants().notify('Error occured. Please try again later');
      });
      if (userModel != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final login = prefs.setString('login', 'token');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false);
      } else {
        setState(() {
          loading = false;
        });
        Constants().notify('Error occured. Please try again later');
      }
    }
  }
}
