import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/Commonlogin.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/customerregister/customerdetails.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/shopownwe/shopownerdetail.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_bottum_bar.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Customer_Shop_Main_Page.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/customer_Bottom.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    initTo();
  }

  void initTo() async {
    await Future.delayed(Duration(seconds: 2));

    User? user = _auth.currentUser;

    if (user == null) {
      Get.off(() => Commonlogin(), transition: Transition.fade);
    } else {
      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(user.uid).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;

        if (data["role"] == 'Customer') {
          if (data["isCustomerVerified"] == true) {
            Get.off(() => CustomerShopMainPage(), transition: Transition.fade);
          } else {
            Get.off(() => Customerdetails(), transition: Transition.fade);
          }
        } else if (data["role"] == "ShopOwner") {
          if (data["isShopVerified"] == true) {
            Get.off(() => ShopBottumBar(), transition: Transition.fade);
          }else{
            Get.off(() => Shopownerdetail(), transition: Transition.fade);

          }
        } else {
          // If role is missing, fallback
          Get.off(() => Commonlogin(), transition: Transition.fade);
        }
      } else {
        // User document doesn't exist
        Get.off(() => Commonlogin(), transition: Transition.fade);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/Screenshot 2025-03-26 131955.png",
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
