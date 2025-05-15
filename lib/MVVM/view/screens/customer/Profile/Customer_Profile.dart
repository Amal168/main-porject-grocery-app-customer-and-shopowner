
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/profile_buttons.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/text_display_cards.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/Commonlogin.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/customer_Rating.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/edit_customer_profile.dart';
class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _ShopprofileState();
}

class _ShopprofileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Profile"),
        // leading: Icon(Icons.keyboard_return),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        const Row(
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
                        SizedBox(
                          height: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditCustomerProfile()));
                            },
                            icon: Icon(
                              Icons.edit_square,
                              size: 35,
                            ))
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
              TextDisplayCards(text: "Location", cardhight: 96, cardwidth: 360),
              SizedBox(
                height: 10,
              ),
              ProfileButtons(
                iconph: Icon(Icons.feedback),
                text: "Feedback",
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CustomerRating()));
                },
              ),
              SizedBox(
                height: 10,
              ),
              ProfileButtons(
                iconph: Icon(Icons.light_mode),
                text: "LightMode",
                ontap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              ProfileButtons(
                iconph: Icon(Icons.logout),
                text: "Logout",
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Commonlogin()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
