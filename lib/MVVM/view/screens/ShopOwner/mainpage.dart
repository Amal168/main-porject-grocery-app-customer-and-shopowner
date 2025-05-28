import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderReceved.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderSend.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int selected = 0;

  final List<String> _labels = ['Received', 'Sent'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: toggle2color,
        elevation: 0,
        title: const Text(
          "Order Manager",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: const AssetImage("assets/dummy profile photo.jpg"),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: ToggleSwitch(
                minWidth: 140.0,
                minHeight: 50.0,
                initialLabelIndex: selected,
                totalSwitches: 2,
                labels: _labels,
                radiusStyle: true,
                cornerRadius: 20,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey.shade200,
                activeBgColors: [
                  [toggle2color],
                  [toggle2color]
                ],
                onToggle: (index) {
                  setState(() {
                    selected = index!;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: selected == 0 ? const Orderreceved() : const Ordersend(),
          ),
        ],
      ),
    );
  }
}
