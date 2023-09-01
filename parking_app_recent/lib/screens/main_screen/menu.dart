import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/model/users.dart';
import 'package:parking_app/screens/authentication/authentication_main.dart';
import 'package:parking_app/screens/menu/subscription.dart';
import 'package:parking_app/services/firebase_functions.dart';
import '../menu/contact_us.dart';
import '../menu/faq.dart';
import 'package:parking_app/screens/main_screen/widget/card_widget.dart';
import 'package:parking_app/screens/payment_stripe.dart';
import '../menu/privacy_policy.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;
  UserModel? userModel;
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  final List<String> menuTitleArray = [
    // 'account',
    'contact us',
    'FAQ',
    //'Privacy Policy',
    'about us',
    // 'subscription',
    'logout'
  ];

  _logout() async {
    setState(() {
      loading = true;
    });
    await firebaseFunctions.logout();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthMain()),
        (Route<dynamic> route) => false);
  }

  final List<Icon> menuIconArray = [
    // Icon(Icons.account_circle_outlined, size: 40, color: Colors.blue),
    Icon(Icons.message_outlined, size: 40, color: Colors.blue),
    Icon(Icons.question_answer_outlined, size: 40, color: Colors.blue),
    Icon(Icons.book_online_rounded, size: 40, color: Colors.blue),
    Icon(Icons.info_outlined, size: 40, color: Colors.blue),
    Icon(Icons.payment_outlined, size: 40, color: Colors.blue),
    Icon(Icons.logout, size: 40, color: Colors.blue)
  ];

  _menuCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 05, 20, 20),
      child: GridView.builder(
        itemCount: menuTitleArray.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // if (menuTitleArray[index] == 'account')
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => Payment()));
              if (menuTitleArray[index] == 'FAQ')
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Faq()));
              else if (menuTitleArray[index] == 'contact us')
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              // else if (menuTitleArray[index] == 'Privacy Policy')
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => PrivacyPolicy()));
              else if (menuTitleArray[index] == 'about us')
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              // else if (menuTitleArray[index] == 'subscription')
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => Subscription()));
              else if (menuTitleArray[index] == 'logout') {
                _logout();
              }
            },
            child: CardWidget(menuTitleArray[index], menuIconArray[index]),
          );
        },
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _userInfoCard(BuildContext context, UserModel userModel) {
    User? user = _auth.currentUser;
    return Container(
      margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
      height: 70.h,
      width: MediaQuery.sizeOf(context).width,
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Container(
          child: Center(
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue,
                      backgroundImage:
                          NetworkImage(snapshot.data?.data()!['image']),
                    ),
                    title: Text(
                      snapshot.data?.data()!['name'],
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent),
                    ),
                    subtitle: Text(
                      snapshot.data?.data()!['email'],
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void initState() {
  //   _getUserDetails();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.only(top: Functions.getScreenDimension(context,Constants.height) * .2 ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png')),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          children: [
            _userInfoCard(context, userModel!),
            Expanded(child: _menuCard()),
            loading
                ? Container(
                    color: Colors.blue.withOpacity(0.4),
                    height: double.infinity,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Parkify",
                    style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "version 1.0.0",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: 30.h),
                  height:
                      40.h,
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
      bottomSheet: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.blue,
        child: Text(
          "all right reserved @ parkify llc.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 11.0,
              fontFamily: Constants.POPPINS,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
