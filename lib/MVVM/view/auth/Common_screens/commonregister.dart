
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
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/571332.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken))),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.keyboard_return),
              iconSize: 35,
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 188,
                    height: 186,
                    child: Text(
                      "Register\nNow",
                      style: TextStyle(
                          fontSize: 46,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 403,
                    height: 615,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: ToggleSwitch(
                            initialLabelIndex: selected,
                            cornerRadius: 15,
                            animate: true,
                            animationDuration: 1,
                            curve: Curves.easeInCirc,
                            fontSize: 25,
                            inactiveBgColor: Colors.white,
                            activeBgColor: color,
                            borderWidth: 5.0,
                            borderColor: [Colors.white],
                            minWidth: 310,
                            radiusStyle: true,
                            minHeight: 60,
                            labels: _label,
                            totalSwitches: _label.length,
                            onToggle: (index) {
                              setState(() {
                                selected = index!;
                                
                                selected == 0
                                    ? color = [toggle2color]
                                    : [Colors.white];
                                // debugPrint('Selected index: $selected');
                              });
                            },
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            selected == 0 ? Customerregister() : Shopregister()
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
