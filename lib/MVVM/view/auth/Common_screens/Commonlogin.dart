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
  Commonlogin({
    super.key,
  });

  @override
  State<Commonlogin> createState() => _CommonloginState();
}

class _CommonloginState extends State<Commonlogin> {
  final dummyshopemail = "shop@gmail.com";
  final dummyshoppass = "password";
  final dummycustomermail = "customer@gmail.com";
  final dummycustomerpass = "password";
  final email = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/571332.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                                  image: AssetImage(
                                      "assets/Screenshot 2025-03-26 131955.png"))),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Custometextfield(
                          hinttext: "Email",
                          validate: (p0) {
                            if (email.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      elevation: 10,
                                      backgroundColor: toggle2color,
                                      shape: CircleBorder(eccentricity: 0.9),
                                      content: Text(
                                        "Please Enter  Your Email",
                                        textAlign: TextAlign.center,
                                      )));
                            }
                            return null;
                          },
                          textEditingController: email),
                      SizedBox(
                        height: 10,
                      ),
                      Custometextfield(
                          hinttext: "password",
                          validate: (p0) {
                            if (password.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      elevation: 10,
                                      backgroundColor: toggle2color,
                                      shape: CircleBorder(eccentricity: 0.9),
                                      content: Text(
                                        "Please Enter  Your Password",
                                        textAlign: TextAlign.center,
                                      )));
                            }
                            return null;
                          },
                          textEditingController: password),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Forgotpassword()));
                              });
                            },
                            child: Text(
                              "Forgot password",
                              style: TextStyle(
                                fontFamily: "Inknut_Antiqua",
                                color: bluetext,
                                fontSize: 20,
                              ),
                            )),
                      ),
                      Customebutton(
                          width: 350,
                          hight: 60,
                          textcolor: Colors.white,
                          textsize: 20,
                          textweight: FontWeight.bold,
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              final currentUser =
                                  await Firebaseothservices().signin(
                                context,
                                email.text.trim(),
                                password.text.trim(),
                              );

                              if (currentUser != null) {
                                final uid =
                                    FirebaseAuth.instance.currentUser?.uid;

                                final userDoc = await Firebaseothservices()
                                    .dbuser
                                    .collection('users')
                                    .doc(uid)
                                    .get();

                                if (userDoc.exists) {
                                  final role = userDoc.data()?['role'];
                                  final isCustomerVerified = userDoc.data()?['isCustomerVerified'];
                                  final isShopVerified = userDoc.data()?['isShopVerified'];

                                  if (role == 'Customer') {
                                  if(isCustomerVerified==true){
                                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              CustomerShopMainPage()),
                                    );
                                  }else{
                                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              Customerdetails()),
                                    );
                                  }
                                  } else if (role == 'ShopOwner') {
                                  if(isShopVerified == true){
                                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ShopBottumBar()),
                                    );
                                  }else{
                                     Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Shopownerdetail()),
                                    );
                                  }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Role not recognized")),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "User document does not exist")),
                                  );
                                }
                              }
                            }

                            // if (formkey.currentState!.validate()) {
                            //   if (email.text == dummyshopemail &&
                            //       password.text == dummyshoppass) {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (_) => ShopBottumBar()));
                            //   } else if (email.text == dummycustomermail &&
                            //       password.text == dummycustomerpass) {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (_) =>
                            //                 CustomerShopMainPage()));
                            //   } else if (email.text.isEmpty &&
                            //       password.text.isEmpty) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(
                            //             elevation: 10,
                            //             backgroundColor: toggle2color,
                            //             shape:
                            //                 CircleBorder(eccentricity: 0.9),
                            //             content: Text(
                            //               "Please Enter  Your Email And Password",
                            //               textAlign: TextAlign.center,
                            //             )));
                            //   }
                            // }
                          },
                          text: "Login",
                          textstyl: "Inknut_Antiqua",
                          color: WidgetStatePropertyAll(redbutton)),
                      SizedBox(
                        height: 58,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: Image(
                            image: AssetImage(
                                "assets/google-icon-logo-symbol-free-png.webp")),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don't have account ?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Inknut_Antiqua",
                              )),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Commonregister()));
                                });
                              },
                              child: Text("Register now",
                                  style: TextStyle(
                                    color: bluetext,
                                    fontSize: 15,
                                    fontFamily: "Inknut_Antiqua",
                                  )))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
