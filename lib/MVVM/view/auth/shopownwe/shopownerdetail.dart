import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_bottum_bar.dart';

class Shopownerdetail extends StatefulWidget {
  const Shopownerdetail({super.key});

  @override
  State<Shopownerdetail> createState() => _ShopownerdetailState();
}

class _ShopownerdetailState extends State<Shopownerdetail> {
  final _name = TextEditingController();
  final _shopname = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _shoptime = TextEditingController();
  final _place = TextEditingController();
  final _location = TextEditingController();
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
                          "Shop Details",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 30),

                        Custometextfield(
                          hinttext: "Full Name",
                          textEditingController: _name,
                          validate: (value) =>
                              value!.isEmpty ? "Enter your name" : null,
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          hinttext: "Shop Name",
                          textEditingController: _shopname,
                          validate: (value) =>
                              value!.isEmpty ? "Enter your shop name" : null,
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          keyboard: TextInputType.number,
                          hinttext: "Phone Number",
                          textEditingController: _phone,
                          validate: (value) {
                            if (value!.isEmpty) return "Enter your phone";
                            if (value.length != 10) return "Enter a valid phone";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          hinttext: "Email Address",
                          textEditingController: _email,
                          validate: (value) =>
                              value!.isEmpty ? "Enter your email" : null,
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          keyboard: TextInputType.text,
                          hinttext: "Shop Timings (e.g. 9am to 9pm)",
                          textEditingController: _shoptime,
                          validate: (value) =>
                              value!.isEmpty ? "Enter your shop time" : null,
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          hinttext: "Place",
                          textEditingController: _place,
                          validate: (value) =>
                              value!.isEmpty ? "Enter your place" : null,
                        ),
                        const SizedBox(height: 12),

                        Custometextfield(
                          hinttext: "Location",
                          textEditingController: _location,
                          length: 5,
                          validate: (value) =>
                              value!.isEmpty ? "Enter your location" : null,
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
                                "name": _name.text.trim(),
                                "phone": _phone.text.trim(),
                                "place": _place.text.trim(),
                                "shopname": _shopname.text.trim(),
                                "shoptime": _shoptime.text.trim(),
                                "location": _location.text.trim(),
                                "isShopVerified": true,

                              });

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ShopBottumBar(),
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
