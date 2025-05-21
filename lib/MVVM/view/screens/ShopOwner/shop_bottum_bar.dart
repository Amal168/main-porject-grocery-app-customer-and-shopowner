
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/addoffers.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderReceivedSend.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/shopitems.dart';
class ShopBottumBar extends StatefulWidget {
  const ShopBottumBar({super.key});

  @override
  State<ShopBottumBar> createState() => _ShopBottumBarState();
}

class _ShopBottumBarState extends State<ShopBottumBar> {
  List currentPage = [Orderreceivedsend(), Shopitems(), Addoffers()];
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(child: currentPage.elementAt(_selectedindex),),
      bottomNavigationBar: Padding(
      
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: Container(
          width: 330,
          height: 60,
          decoration: BoxDecoration(
            
            // color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black26)),
          child: Card(
            elevation: 10,
            child: GNav(
                onTabChange: (value) {
                  setState(() {
                    _selectedindex = value;
                  });
                },
                selectedIndex: _selectedindex,
                // tabMargin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // backgroundColor: redbutton,
                // color: greenbutton,
                activeColor: Colors.white,
                // tabBorder: Border.all(),
                textSize: 20,
                tabBorderRadius: 20,
                textStyle: TextStyle(
                    fontFamily: "Inria_Sans",
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                iconSize: 22,
                gap: 5,
                tabs: [
                  GButton(
                    icon: Icons.shopping_basket,
                    text: "Order",
                    backgroundColor: toggle2color,
                  ),
                  GButton(
                      icon: Icons.shop,
                      text: "Items",
                      backgroundColor: toggle2color),
                  GButton(
                      icon: Icons.local_offer,
                      text: "Offers",
                      backgroundColor: toggle2color),
                ]),
          ),
        ),
      ),
    );
  }
}
