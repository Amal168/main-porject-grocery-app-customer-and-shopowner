import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase auth import
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    if (formKey.currentState!.validate()) {
      try {
        await Firebaseothservices().signin(
          context,
          email.text.trim(),
          password.text.trim(),
        );
        // Navigate to home or dashboard
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login successful")),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Login failed")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/571332.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Dark overlay shade
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // App Logo
                        Container(
                          height: 160,
                          width: 160,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 12),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/Screenshot 2025-03-26 131955.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Login to continue",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 30),

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
                        const SizedBox(height: 16),

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
                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const Forgotpassword()),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Customebutton(
                          width: double.infinity,
                          hight: 55,
                          textcolor: Colors.white,
                          textsize: 18,
                          textweight: FontWeight.w600,
                          text: "Login",
                          textstyl: "Inknut_Antiqua",
                          color: WidgetStatePropertyAll(toggle3color),
                          onPressed: 
                             () async {
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
                          
                        const SizedBox(height: 24),

                        Row(
                          children: const [
                            Expanded(child: Divider(thickness: 1, color: Colors.white24)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("OR", style: TextStyle(color: Colors.white70)),
                            ),
                            Expanded(child: Divider(thickness: 1, color: Colors.white24)),
                          ],
                        ),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const Commonregister()),
                                );
                              },
                              child: const Text(
                                "Register now",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
