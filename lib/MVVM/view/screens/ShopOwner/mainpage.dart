
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

class _MainpageState extends State<Mainpage>
    with TickerProviderStateMixin {
  List colors = [Colors.black];
  late TabController tabcontrol;

  @override
  void initState() {
    super.initState();
    tabcontrol = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabcontrol.dispose();
    super.dispose();
  }

  final List<String> _label = ['Recive', 'Send'];
  List<Color> color = [toggle2color];
  @override
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Align(alignment: Alignment.topLeft, child: CircleAvatar(child: Image(image: AssetImage("assets/dummy profile photo.jpg")),)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: ToggleSwitch(
                initialLabelIndex: selected,
                cornerRadius: 15,
                animate: true,
                animationDuration: 300,
                curve: Curves.easeInOut,
                fontSize: 18,
                inactiveBgColor: Colors.white,
                activeBgColor: color,
                borderWidth: 3.0,
                borderColor: [Colors.black],
                dividerMargin: 10,
                minWidth: 310,
                
                radiusStyle: true,
                minHeight: 60,
                labels: _label,
                totalSwitches: _label.length,
                onToggle: (index) {
                  setState(() {
                    selected = index!;

                    selected == 0 ? color = [toggle2color] : [Colors.white];
                    // debugPrint('Selected index: $selected');
                  });
                },
              ),
            ),
          ),
          Expanded(child: selected == 0 ? Orderreceved() : Ordersend()),
        ],
      ),
    );
  }
}
