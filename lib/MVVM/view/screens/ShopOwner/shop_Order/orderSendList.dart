
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/Shop_Customer_Chat.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/shop_customer_profile.dart';
class Ordersendlist extends StatefulWidget {
  const Ordersendlist({super.key});

  @override
  State<Ordersendlist> createState() => _OrdersendlistState();
}

class _OrdersendlistState extends State<Ordersendlist> {
  List<String> selectedRadioValues = List.generate(3, (index) => '');
  String radiobuttion = " ";
  final _subtotal = TextEditingController();
  final _detiveryFee = TextEditingController();
  final _discount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_return)),
          title:const Text(
            "List",
            style: TextStyle(
                fontSize: 20,
                fontFamily: "Inknut_Antiqua",
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ShopCustomerChat()));
                },
                icon: Icon(Icons.chat)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ShopCustomerProfile()));
                },
                icon: Icon(Icons.person))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "asset/images.jpg",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Row(
                    children: [
                     const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text("1 Piece"),
                          Text("20Rs"),
                        ],
                      ),
                     const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: "1",
                                groupValue: selectedRadioValues[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedRadioValues[index] = value!;
                                  });
                                },
                              ),
                              Text("Check"),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                value: "2",
                                groupValue: selectedRadioValues[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedRadioValues[index] = value!;
                                  });
                                },
                              ),
                              Text("Uncheck"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: 3),
        ),
        bottomSheet: Container(
          width: double.infinity,
          height: 258,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                   const Text(
                      "Subtotal",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inknut_Antiqua",
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 88,
                      height: 32,
                      child: TextFormField(
                        controller: _subtotal,
                        validator: (value) {},
                        decoration: InputDecoration(
                            hintText: "40.00Rs",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  const  Text(
                      "Delivery Fee",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inknut_Antiqua",
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 88,
                      height: 32,
                      child: TextFormField(
                        controller: _detiveryFee,
                        validator: (value) {},
                        decoration: InputDecoration(
                            hintText: "2.00Rs",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    )
                  ],
                ),
              const  SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  const  Text(
                      "Discount",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inknut_Antiqua",
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 88,
                      height: 32,
                      child: TextFormField(
                        controller: _subtotal,
                        validator: (value) {},
                        decoration: InputDecoration(
                            hintText: "0.00Rs",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                            )),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                        splashRadius: 50,
                        value: '1',
                        groupValue: radiobuttion,
                        onChanged: (newValue) {
                          setState(() {
                            radiobuttion = newValue!;
                          });
                        }),
                  const  Text("Check",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Inria_Sans",
                            fontWeight: FontWeight.bold)),
                    Radio<String>(
                        // title: const Text("Invisible"),
                        value: '2',
                        groupValue: radiobuttion,
                        onChanged: (newValue) {
                          setState(() {
                            radiobuttion = newValue!;
                          });
                        }),
                   const Text("Uncheck",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Inria_Sans",
                            fontWeight: FontWeight.bold))
                  ],
                ),
                MaterialButton(
                    elevation: 10.0,
                    minWidth: 337,
                    height: 40,
                    color: greenbutton,
                    shape: Border.all(color: Colors.black26),
                    onPressed: () {},
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Total: ",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Inknut_Antiqua",
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "40.00Rs",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Inria_Sans",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 93,
                        ),
                        Text(
                          "Send",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Inknut_Antiqua",
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.send)
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
