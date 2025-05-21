import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/text_display_cards.dart';

class CustomerShop extends StatefulWidget {
  const CustomerShop({super.key});

  @override
  State<CustomerShop> createState() => _CustomerShopState();
}

class _CustomerShopState extends State<CustomerShop> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                            "Shop Owner",
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
            TextDisplayCards(text: "Location", cardhight: 159, cardwidth: 360),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
