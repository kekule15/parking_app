import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parking_app/model/users.dart';
import 'package:parking_app/screens/authentication/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseAuthInstance = FirebaseAuth.instance;

  
 

  Future signInUsingEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuthInstance
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      if (user == null) {
        return UserModel("name", "email", "phoneNumber", "profilePictureUrl");
      }
      return UserModel(
          user.displayName, user.email, user.phoneNumber, user.photoURL);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    
  }

  

  

  Future<bool> logout() async {
    // await FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('login');
    return true;
  }
}
