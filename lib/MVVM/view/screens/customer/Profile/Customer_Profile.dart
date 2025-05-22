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
        automaticallyImplyLeading: false,
        title: Align(
            alignment: Alignment.center,
            child: Text(
              "My Profile",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
        // leading: Icon(Icons.keyboard_return),
        backgroundColor: toggle2color,
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
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 125,
                                height: 125,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/dummy profile photo.jpg"))),
                              ),
                              SizedBox(height: 10,),
                              Text("Customer Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: toggle2color),),
                              Text("1234567890",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Customer@gmail.com",style: TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                EditCustomerProfile()));
                                  },
                                  icon: Icon(
                                    Icons.edit_square,
                                    size: 40,
                                  )))
                        ],
                      )),
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
