import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/addproduct.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/itemt_abs/Soap_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/itemt_abs/all_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/itemt_abs/cookingoil_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/itemt_abs/rice_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/itemt_abs/snacks_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/itemt_abs/toothpaste_tab.dart';

class Shopitems extends StatefulWidget {
  const Shopitems({super.key});

  @override
  State<Shopitems> createState() => _ShopitemsState();
}

class _ShopitemsState extends State<Shopitems>
    with SingleTickerProviderStateMixin {
  late TabController tabcontrol;

  @override
  void initState() {
    super.initState();
    tabcontrol = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    tabcontrol.dispose();
    super.dispose();
  }

  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: toggle2color,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 250,
            height: 35,
            child: TextFormField(
              validator: (value) {},
              controller: search,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.white)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Addproduct()));
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        weight: 50,
                      )),
                ),
                Positioned(
                    right: 0,
                    top: 20,
                    child: Container(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: Icon(Icons.add),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: appbuttoncolor),
                    ))
              ],
            ),
          )
        ],
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          isScrollable: true, controller: tabcontrol, tabs: [
          Tab(
            text: "all",
          ),
          Tab(
            text: "Rice",
          ),
          Tab(
            text: "Soap",
          ),
          Tab(
            text: "Snacks",
          ),
          Tab(
            text: "Toothpaste",
          ),
          Tab(
            text: "Cooking Oil",
          ),
        ]),
      ),
      body: Expanded(
        child: TabBarView(controller: tabcontrol, children: [
           AllTab(),
          // Center(
          //   child: Text("All"),
          // ),
          // Center(child: Text("Rice"),),
          Ricetab(),
          SoapTab(),
          SnacksTab(),
          ToothpasteTab(),
          CookingoilTab()
        ]),
      ),
    );
  }
}
