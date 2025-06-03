import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/models/all_user_model.dart';

class Firebaseothservices {
  // create a auth as instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final  uid = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore dbuser = FirebaseFirestore.instance;

  // create a function for signin
  Future<UserCredential?> signin(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Entered Scussefully",textAlign: TextAlign.center,)));
      }
      return credential;
    } on FirebaseAuthException {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Somthing Went Wrong",textAlign: TextAlign.center)));
      }
    } catch (e) {
      print(e);
    }
  }
  // create a function for createUser

  Future<User?> createUser(
    BuildContext context,
    String email,
    String password,
    String role,
  ) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = credential.user;
      if (user != null) {
        AllUserModel userData = AllUserModel(
          createAt: FieldValue.serverTimestamp(),
          email: auth.currentUser!.email,
          Address: '',
          uid: FirebaseAuth.instance.currentUser?.uid,
          location: '',
          phone: '',
          name: '',
          role: role
        );
        await dbuser.collection('users').doc(auth.currentUser?.uid).set(userData.toMap());
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("created Sccuessfully")));
      }
      return user;
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
      return auth.signInWithCredential(credential);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Wrong")));
    }
  }

  // create a function for signout

  Future<void> signOut() async {
    auth.signOut();
  }
}
