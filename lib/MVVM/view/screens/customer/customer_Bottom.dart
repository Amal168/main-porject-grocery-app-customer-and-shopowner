import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Customer_shop.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/customer_order.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/Product_items.dart';

class CustomerBottom extends StatefulWidget {
  const CustomerBottom({super.key});

  @override
  State<CustomerBottom> createState() => _CustomerBottomState();
}

class _CustomerBottomState extends State<CustomerBottom> {
  final List<Widget> _customerPages = [
     ProductItems(),
    const CustomerOrder(),
    const CustomerShop()
  ];
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _customerPages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTap,
            backgroundColor: Colors.white,
            elevation: 10,
            selectedItemColor: Colors.green.shade700,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront),
                label: 'Shop',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
