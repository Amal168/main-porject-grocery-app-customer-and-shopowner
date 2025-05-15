
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/profile_buttons.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/text_display_cards.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/shopCommentRating.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_profile/shopEditPrfile.dart';
class Shopprofile extends StatefulWidget {
  const Shopprofile({super.key});

  @override
  State<Shopprofile> createState() => _ShopprofileState();
}

class _ShopprofileState extends State<Shopprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Profile"),
          // leading: Icon(Icons.keyboard_return),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Stack(children: [
                              CircleAvatar(
                                radius: 62.5,
                                backgroundColor: photocolor,
                                child: Icon(
                                  Icons.person,
                                  size: 94,
                                ),
                              ),
                              Positioned(
                                  right: -10,
                                  bottom: -10,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.camera_enhance,
                                        size: 30,
                                      )))
                            ]),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Shop Owner",
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
                                      builder: (_) => Shopeditprfile()));
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
              Card(
                color: Colors.white,
                elevation: 10,
                child: Container(
                  width: 360,
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
                            Stack(children: [
                              CircleAvatar(
                                radius: 62.5,
                                backgroundColor: photocolor,
                                child: Icon(
                                  Icons.person,
                                  size: 94,
                                ),
                              ),
                              Positioned(
                                  right: -10,
                                  bottom: -10,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.camera_enhance,
                                        size: 30,
                                      )))
                            ]),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shop Name",
                                  style: TextStyle(fontSize: 34),
                                ),
                                Text(
                                  "Shop time",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
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
                height: 10,
              ),
              ProfileButtons(
                iconph: Icon(Icons.feedback),
                text: "Feedback",
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Shopcommentrating()));
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
                ontap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
