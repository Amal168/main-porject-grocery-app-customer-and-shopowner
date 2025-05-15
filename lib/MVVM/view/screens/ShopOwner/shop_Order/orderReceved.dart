import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderReceavedList.dart';
class Orderreceved extends StatefulWidget {
  const Orderreceved({super.key});

  @override
  State<Orderreceved> createState() => _OrderrecevedState();
}

class _OrderrecevedState extends State<Orderreceved> {
  List Recive = [
    "Sithara",
    "Arjune",
    "Pokiry",
    "vishal",
    "Sehal"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: Recive.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Orderreceavedlist()));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(Recive[index]),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
