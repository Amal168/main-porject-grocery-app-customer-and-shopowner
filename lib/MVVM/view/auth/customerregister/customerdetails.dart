import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Customer_Shop_Main_Page.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/customer_Bottom.dart';

class Customerdetails extends StatefulWidget {
  const Customerdetails({super.key});

  @override
  State<Customerdetails> createState() => _CustomerdetailsState();
}

class _CustomerdetailsState extends State<Customerdetails> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final place = TextEditingController();
  final location = TextEditingController();
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
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_return),
              iconSize: 35,
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 91,
                      child: Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 46,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Custometextfield(
                              hinttext: "Name",
                              validate: (p0) {
                                if (name.text.isEmpty) {
                                  return "Enter Your Name";
                                }
                                return null;
                              },
                              textEditingController: name),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              keyboard: TextInputType.number,
                              hinttext: "Phone",
                              validate: (p0) {
                                if (phone.text.isEmpty) {
                                  return "Enter Your Phone";
                                } else if (phone.text.length != 10) {
                                  return "Check Your Phone";
                                }
                                return null;
                              },
                              textEditingController: phone),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              hinttext: "Email",
                              validate: (p0) {
                                if (email.text.isEmpty) {
                                  return "Enter Your Email";
                                }
                                return null;
                              },
                              textEditingController: email),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              hinttext: "Place",
                              validate: (p0) {
                                if (place.text.isEmpty) {
                                  return "Enter Your place";
                                }
                                return null;
                              },
                              textEditingController: place),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                            hinttext: "Location",
                            validate: (p0) {
                              if (location.text.isEmpty) {
                                return "Enter Your Location";
                              }
                              return null;
                            },
                            textEditingController: location,
                            length: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Customebutton(
                        textcolor: Colors.white,
                        textsize: 20,
                        textweight: FontWeight.bold,
                        width: 350,
                        hight: 60,
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            await Firebaseothservices()
                                .dbuser
                                .collection('users')
                                .doc(Firebaseothservices().uid)
                                .update({
                              "name": name.text.trim(),
                              "phone": phone.text.trim(),
                              "place": place.text.trim(),
                              "location": location.text.trim(),
                              "isCustomerVerified": true,
                            });

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerShopMainPage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        text: "Submit",
                        color: WidgetStatePropertyAll(redbutton))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
