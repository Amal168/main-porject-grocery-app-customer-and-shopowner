
import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/571332.jpg"),
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
          body: Form(
            key: formkey,
            child: Center(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
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
                                if (_name.text.isEmpty) {
                                  return "Enter your Name";
                                }
                                return null;
                              },
                              textEditingController: _name),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              hinttext: "ShopName",
                              validate: (p0) {
                                if (_shopname.text.isEmpty) {
                                  return "Enter your Shopname";
                                }
                                return null;
                              },
                              textEditingController: _shopname),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              keyboard: TextInputType.number,
                              hinttext: "Phone",
                              validate: (p0) {
                                if (_phone.text.isEmpty) {
                                  return "Enter your Phone";
                                }else  if (_phone.text.length!=10) {
                                  return "Check your Phone";
                                }
                                return null;
                              },
                              textEditingController: _phone),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              hinttext: "Email",
                              validate: (p0) {
                                if (_email.text.isEmpty) {
                                  return "Enter your Email";
                                }
                                return null;
                              },
                              textEditingController: _email),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              keyboard: TextInputType.numberWithOptions(),
                              hinttext: "Shoptime",
                              validate: (p0) {
                                if (_shoptime.text.isEmpty) {
                                  return "Enter your Time";
                                }
                                return null;
                              },
                              textEditingController: _shoptime),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                              hinttext: "Place",
                              validate: (p0) {
                                if (_place.text.isEmpty) {
                                  return "Enter your Place";
                                }
                                return null;
                              },
                              textEditingController: _place),
                          SizedBox(
                            height: 10,
                          ),
                          Custometextfield(
                            hinttext: "Location",
                            validate: (p0) {
                              if (_location.text.isEmpty) {
                                return "Enter your Location";
                              }
                              return null;
                            },
                            textEditingController: _location,
                            length: 5,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Customebutton(
                        textsize: 20,
                        textweight: FontWeight.bold,
                        textcolor: Colors.white,
                        width: 350,
                        hight: 60,
                        onPressed: () {
                         if (formkey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ShopBottumBar()));
                          } else if (formkey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please Enter All Datas")));
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
