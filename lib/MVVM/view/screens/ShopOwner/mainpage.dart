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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [toggle2color.withOpacity(0.9), toggle2color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: toggle2color.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                const Text(
                  "Order Manager",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        AssetImage("assets/dummy profile photo.jpg"),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: ToggleSwitch(
                  minWidth: 130.0,
                  minHeight: 45.0,
                  initialLabelIndex: selected,
                  totalSwitches: 2,
                  labels: _labels,
                  radiusStyle: true,
                  cornerRadius: 20,
                  fontSize: 16,
                  activeFgColor: Colors.white,
                  inactiveFgColor: Colors.black87,
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
          ),

          const SizedBox(height: 10),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                          begin: const Offset(0.1, 0), end: Offset.zero)
                      .animate(animation),
                  child: child,
                ),
              ),
              child: selected == 0
                  ? const Orderreceved(key: ValueKey('received'))
                  : const Ordersend(key: ValueKey('sent')),
            ),
          ),
        ],
      ),
    );
  }
}
