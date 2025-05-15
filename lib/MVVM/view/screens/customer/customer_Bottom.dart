
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
  final List<Widget> _CustomerPage = [
    ProductItems(),
    CustomerOrder(),
    CustomerShop()
  ];
  int _selectedindex = 0;

  void _ontapMethod(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _CustomerPage[_selectedindex],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
          child: Card(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                  color: Colors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      _selectedindex == 0 ? Colors.green : Colors.white,
                    )),
                    onPressed: () => _ontapMethod(0),
                    child: Text(
                      'Products',
                      style: TextStyle(
                        color:
                            _selectedindex == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      _selectedindex == 1 ? Colors.green : Colors.white,
                    )),
                    onPressed: () => _ontapMethod(1),
                    child: Text(
                      'Orders',
                      style: TextStyle(
                        color:
                            _selectedindex == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                      _selectedindex == 2 ? Colors.green : Colors.white,
                    )),
                    onPressed: () => _ontapMethod(2),
                    child: Text(
                      'Shop',
                      style: TextStyle(
                        color:
                            _selectedindex == 2 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
