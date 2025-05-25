import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/commonregister.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/forgotpassword.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/customerregister/customerdetails.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/shopownwe/shopownerdetail.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_bottum_bar.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Customer_Shop_Main_Page.dart';

class Commonlogin extends StatefulWidget {
  const Commonlogin({super.key});

  @override
  State<Commonlogin> createState() => _CommonloginState();
}

class _CommonloginState extends State<Commonlogin> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/571332.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/Screenshot 2025-03-26 131955.png"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                  Custometextfield(
                    hinttext: "Email",
                    textEditingController: email,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Custometextfield(
                    hinttext: "Password",
                    textEditingController: password,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Forgotpassword()));
                      },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(
                          fontFamily: "Inknut_Antiqua",
                          color: bluetext,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Customebutton(
                    width: 350,
                    hight: 60,
                    textcolor: Colors.white,
                    textsize: 20,
                    textweight: FontWeight.bold,
                    text: "Login",
                    textstyl: "Inknut_Antiqua",
                    color: WidgetStatePropertyAll(redbutton),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final currentUser = await Firebaseothservices().signin(
                            context,
                            email.text.trim(),
                            password.text.trim(),
                          );

                          if (currentUser != null) {
                            final uid = Firebaseothservices().uid;
                            final userDoc = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .get();

                            if (userDoc.exists) {
                              final data = userDoc.data()!;
                              final role = data['role'];
                              final isCustomerVerified = data['isCustomerVerified'];
                              final isShopVerified = data['isShopVerified'];

                              if (role == 'Customer') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => isCustomerVerified == true
                                        ? CustomerShopMainPage()
                                        : Customerdetails(),
                                  ),
                                );
                              } else if (role == 'ShopOwner') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => isShopVerified == true
                                        ? ShopBottumBar()
                                        : Shopownerdetail(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("User role is not recognized")),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("User document not found.")),
                              );
                            }
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login failed: ${e.toString()}")),
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 58),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: Image(
                      image: AssetImage("assets/google-icon-logo-symbol-free-png.webp"),
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Inknut_Antiqua",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Commonregister()),
                          );
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            color: bluetext,
                            fontSize: 15,
                            fontFamily: "Inknut_Antiqua",
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
