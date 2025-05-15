
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/profile_buttons.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/text_display_cards.dart';
class ShopCustomerProfile extends StatefulWidget {
  const ShopCustomerProfile({super.key});

  @override
  State<ShopCustomerProfile> createState() => _ShopCustomerProfileState();
}

class _ShopCustomerProfileState extends State<ShopCustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 10,),
              Card(
                color: Colors.white,
                elevation: 10,
                child: Container(
                  width: 393,
                  height: 246,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: photocolor,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CircleAvatar(
                              radius: 62.5,
                              backgroundColor: photocolor,
                              child: Icon(
                                Icons.person,
                                size: 94,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Customer",
                              style: TextStyle(fontSize: 41),
                            )
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextDisplayCards(
                  text: "Mobile Number", cardhight: 60, cardwidth: 360),
              SizedBox(
                height: 10,
              ),
              
              SizedBox(
                height: 10,
              ),
              TextDisplayCards(text: "Place", cardhight: 60, cardwidth: 360),
              SizedBox(
                height: 10,
              ),
              TextDisplayCards(text: "Email", cardhight: 60, cardwidth: 360),
              SizedBox(
                height: 10,
              ),
              TextDisplayCards(
                  text: "Location", cardhight: 159, cardwidth: 360),
              SizedBox(
                height: 81,
              ),
              ProfileButtons(
                width: 360,
                hieght: 60,
                iconph: Icon(Icons.arrow_back_ios_new),
                text: "Back",
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              
            ],
          ),
        ),
      ),

    );
  }
}