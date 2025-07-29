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
  final List<Widget> _pages = [
    Orderreceivedsend(),
    Shopitems(),
    Addoffers(),
  ];
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index) => setState(() => _selectedIndex = index),
              gap: 8,
              rippleColor: toggle2color.withOpacity(0.1),
              hoverColor: toggle2color.withOpacity(0.1),
              haptic: true,
              tabActiveBorder: Border.all(color: toggle2color, width: 1),
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              color: Colors.grey[700],
              activeColor: Colors.white,
              tabBackgroundColor: toggle2color,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              iconSize: 24,
              textStyle: TextStyle(
                fontFamily: "Inria_Sans",
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              tabs: const [
                GButton(
                  icon: Icons.shopping_basket,
                  text: 'Orders',
                ),
                GButton(
                  icon: Icons.storefront,
                  text: 'Items',
                ),
                GButton(
                  icon: Icons.local_offer,
                  text: 'Offers',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
