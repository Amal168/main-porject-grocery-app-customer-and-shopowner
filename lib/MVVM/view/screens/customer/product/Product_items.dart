import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/Shop_Customer_Chat.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/customer_cart.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/itemt_abs/Customer_all_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/itemt_abs/customer_cookingoil_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/itemt_abs/customer_rice_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/itemt_abs/customer_snacks_tab.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/itemt_abs/customer_toothpaste_tab.dart';
import 'itemt_abs/customer_Soap_tab.dart';

class ProductItems extends StatefulWidget {
  const ProductItems({super.key});

  @override
  State<ProductItems> createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems>
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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: toggle2color,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: search,
            onTap: () => showSearch(context: context, delegate: Customesearch()),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: 'Search products...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        actions: [
          _iconButton(icon: Icons.chat_sharp, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShopCustomerChat()))),
          _iconButton(icon: Icons.shopping_cart, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerCart()))),
        ],
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          isScrollable: true,
          controller: tabcontrol,
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
      body: TabBarView(
        controller: tabcontrol,
        children:  [
          CustomerAllTab(),
          CustomerRiceTab(),
          CustomerSoapTab(),
          CustomerSnacksTab(),
          CustomerToothpasteTab(),
          CustomerCookingoilTab(),
        ],
      ),
    );
  }

  Widget _iconButton({required IconData icon, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(icon, color: toggle2color),
          onPressed: onTap,
        ),
      ),
    );
  }
}

class Customesearch extends SearchDelegate {
  List<String> searchterms = ["Matta", "Soup", "Cooking Oil", "Biriyani Rice"];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final matchQuery = searchterms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) => ListTile(title: Text(matchQuery[index])),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final matchQuery = searchterms
        .where((term) => term.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) => ListTile(title: Text(matchQuery[index])),
    );
  }
}
