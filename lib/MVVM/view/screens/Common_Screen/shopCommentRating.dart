import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';

class Shopcommentrating extends StatefulWidget {
  const Shopcommentrating({super.key});

  @override
  State<Shopcommentrating> createState() => _ShopcommentratingState();
}

class _ShopcommentratingState extends State<Shopcommentrating> {
  final _comments = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Comment",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )),
              Card(
                elevation: 10,
                child: TextFormField(
                  maxLines: 5,
                  controller: _comments,
                  validator: (value) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Rating",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  )),
              // add a reting system
              Container(
                width: 360,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(15)),
                child: Card(
                  elevation: 10,
                  child: Center(
                    child: RatingBar.builder(
                        glowColor: greenbutton,
                        glowRadius: 10,
                        initialRating: 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3),
                        itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: toggle3color,
                              size: 50,
                            ),
                        onRatingUpdate: (rating) {}),
                  ),
                ),
              ),
              SizedBox(
                height: 84,
              ),

              Customebutton(
                  shape: WidgetStatePropertyAll(BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                  width: 150,
                  hight: 50,
                  textsize: 24,
                  textcolor: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Your message has been send")));
                  },
                  text: "Send",
                  color: WidgetStatePropertyAll(toggle3color))
            ],
          ),
        ),
      ),
    );
  }
}
