import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebaseothsurvices {
  // create a auth as instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a function for signin
  Future<UserCredential?> signin(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Entered Scussefully")));
      }
      return credential;
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Somthing Went Wrong")));
      }
    } catch (e) {
      print(e);
    }
  }
  // create a function for createUser

  Future<UserCredential?> createUser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("created Sccuessfully")));
      }
      return credential;
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
      }
    } catch (e) {
      print(e);
    }
  }
  //create a funtion for Google Signin
  Future<UserCredential?> googlesignin(BuildContext context) async {
    try {
      GoogleSignInAccount? gooleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? userauth =
          await gooleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userauth?.accessToken, idToken: userauth?.accessToken);
      return _auth.signInWithCredential(credential);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Wrong")));
    }
  }

  // create a function for signout

  Future<void> signOut() async {
    _auth.signOut();
  }
}

