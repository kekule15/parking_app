import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/helper/funtions.dart';
import 'package:parking_app/model/users.dart';
import 'package:parking_app/screens/main_screen/main_screen.dart';
import 'package:parking_app/services/firebase_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SocialSignUpInfo extends StatefulWidget {
  final UserModel user;
  SocialSignUpInfo(this.user);

  @override
  _SocialSignUpInfoState createState() =>
      _SocialSignUpInfoState();
}

class _SocialSignUpInfoState extends State<SocialSignUpInfo> {

  FirebaseFunctions firebaseFunctions = new FirebaseFunctions();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  // _authMethod() async{
  //   if(phoneNumberController.text.toString()  != "" && passwordController.text.toString() != ""){
  //     setState(() {
  //       loading = true;
  //     });

  //     await firebaseFunctions.pushAdditionalUserDetailsToFirebase(
  //         widget.user.name, phoneNumberController.text,widget.user.email,passwordController.text,"00/00/0000",widget.user.profilePictureUrl);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setBool('login', true);

  //     //Logout
  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // prefs.remove('login');

  //     loading = false;
  //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
  //         MainScreen()), (Route<dynamic> route) => false);
  //   }else{
  //     Flushbar(
  //       title: "Opp!",
  //       message:
  //       "Please fill the empty field(s)",
  //       duration: Duration(seconds: 3),
  //     )..show(context);
  //   }
  // }

 
 
  _nextButton() {
    return Container(
      color: Colors.white,
      child: Container(
          height: 90,
          child: Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.blue),
              child: MaterialButton(
                onPressed: () async {
               //  _authMethod();
                },
                child:  (loading) ? CircularProgressIndicator() : Text(
                  "Next",
                  style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),
                ),
              ),
            ),
          )),
    );
  }

  _content(){
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15,50,15,15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: Functions.getScreenDimension(context, Constants.height) *
                        .06,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                          "${widget.user.profilePictureUrl}"),
                      backgroundColor: Colors.grey[800],
                    ),
                  ),
                  SizedBox(
                    height: Functions.getScreenDimension(context, Constants.height) *
                        .06,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value.isEmpty){
                        return "Please enter your name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_outlined,color: Colors.blueAccent,),
                        hintText: widget.user.name,
                        enabled: false,
                        hintStyle: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          // letterSpacing: 1.5,
                          fontSize: 14.5,
                        )
                    ),
                  ),
                  SizedBox(
                    height: Functions.getScreenDimension(context, Constants.height) *
                        .02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value.isEmpty){
                        return "Please enter your email";
                      }
                      return null;
                    },
                    enabled: false,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined,color: Colors.blueAccent,),
                        hintText: widget.user.email,
                        hintStyle: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          // letterSpacing: 1.5,
                          fontSize: 14.5,
                        )
                    ),
                  ),

                  SizedBox(
                    height: Functions.getScreenDimension(context, Constants.height) *
                        .04,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value.isEmpty){
                        return "Please enter your phone number";
                      }
                      return null;
                    },
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone,color: Colors.blueAccent,),
                        hintText: 'Enter mobile number',
                        hintStyle: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          // letterSpacing: 1.5,
                          fontSize: 14.5,
                        )
                    ),
                  ),
                  SizedBox(
                    height: Functions.getScreenDimension(context, Constants.height) *
                        .02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if(value.isEmpty){
                        return "Please enter your password";
                      }
                      return null;
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.security,color: Colors.blueAccent,),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          fontFamily: Constants.OPEN_SANS,
                          fontWeight: FontWeight.w500,
                          // letterSpacing: 1.5,
                          fontSize: 14.5,
                        )
                    ),
                  ),

                  SizedBox(
                    height: Functions.getScreenDimension(context, Constants.height) *
                        .02,
                  ),
                  _nextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png')))),
              _content()
            ],
          ),
        )
        // bottomSheet: _nextButton(),
      ),
    );
  }
}
