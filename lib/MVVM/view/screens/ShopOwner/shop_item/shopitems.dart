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

  final search = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Search + Cart Row
          Container(
            color: toggle2color,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      controller: search,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Addproduct()));
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appbuttoncolor,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
      
          // TabBar
          Container(
            color: toggle2color,
            child: TabBar(
              controller: tabcontrol,
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Rice"),
                Tab(text: "Soap"),
                Tab(text: "Snacks"),
                Tab(text: "Toothpaste"),
                Tab(text: "Cooking Oil"),
              ],
            ),
          ),
      
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: tabcontrol,
              children:  [
                AllTab(),
                RiceTab(),
                SoapTab(),
                SnacksTab(),
                ToothpasteTab(),
                CookingoilTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
