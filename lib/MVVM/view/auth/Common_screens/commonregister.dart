import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/customerregister/customerRegister.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/shopownwe/shopregister.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Commonregister extends StatefulWidget {
  const Commonregister({super.key});

  @override
  State<Commonregister> createState() => _CommonregisterState();
}

class _CommonregisterState extends State<Commonregister> {
  int selected = 0;
  final List<String> _label = ['Customer', 'ShopOwner'];
  List<Color> color = [toggle2color];

  String selectRole(int selectIndex) => selectIndex == 0 ? 'Customer' : 'ShopOwner';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/571332.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Register Now",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 380,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        children: [
                          ToggleSwitch(
                            initialLabelIndex: selected,
                            labels: _label,
                            totalSwitches: _label.length,
                            activeBgColor: [redbutton],
                            inactiveBgColor: Colors.white,
                            inactiveFgColor: Colors.black87,
                            activeFgColor: Colors.white,
                            cornerRadius: 20,
                            minHeight: 50,
                            minWidth: 160,
                            fontSize: 18,
                            onToggle: (index) {
                              setState(() {
                                selected = index!;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          selected == 0
                              ? Customerregister(role: selectRole(selected))
                              : Shopregister(role: selectRole(selected)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
