import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Customer_Shop_Main_Page.dart';

class Customerdetails extends StatefulWidget {
  const Customerdetails({super.key});

  @override
  State<Customerdetails> createState() => _CustomerdetailsState();
}

class _CustomerdetailsState extends State<Customerdetails> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final location = TextEditingController();
  final Address = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/571332.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: 380,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Your Details",
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 30),

                        Custometextfield(
                          hinttext: "Full Name",
                          textEditingController: name,
                          validate: (value) => value!.isEmpty ? "Enter your name" : null,
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          keyboard: TextInputType.number,
                          hinttext: "Phone Number",
                          textEditingController: phone,
                          validate: (value) {
                            if (value!.isEmpty) return "Enter your phone";
                            if (value.length != 10) return "Enter a valid 10-digit phone";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        

                        Custometextfield(
                          hinttext: "Location",
                          textEditingController: location,
                          validate: (value) => value!.isEmpty ? "Enter your location" : null,
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          hinttext: "Address",
                          textEditingController: Address,
                          length: 5,
                          validate: (value) => value!.isEmpty ? "Enter your location" : null,
                        ),
                        const SizedBox(height: 30),

                        Customebutton(
                          text: "Submit",
                          textcolor: Colors.white,
                          textsize: 18,
                          textweight: FontWeight.bold,
                          width: 320,
                          hight: 55,
                          color: WidgetStatePropertyAll(redbutton),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await Firebaseothservices()
                                  .dbuser
                                  .collection('users')
                                  .doc(Firebaseothservices().uid)
                                  .update({
                                "name": name.text.trim(),
                                "phone": phone.text.trim(),
                                "location": location.text.trim(),
                                "Address": Address.text.trim(),
                                "isCustomerVerified": true,
                              });

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CustomerShopMainPage(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
