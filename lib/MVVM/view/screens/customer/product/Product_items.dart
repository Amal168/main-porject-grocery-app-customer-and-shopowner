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
        automaticallyImplyLeading: false,
        backgroundColor: toggle2color,
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            // width: 250,
            height: 35,
            child: TextFormField(
              cursorHeight: 15,
              mouseCursor: MouseCursor.uncontrolled,
              validator: (value) {
                showSearch(context: context, delegate: Customesearch() );
              },
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
            child: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ShopCustomerChat()));
                  },
                  icon: Icon(
                    Icons.chat_sharp,
                    weight: 50,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CustomerCart()));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    weight: 50,
                  )),
            ),
          )
        ],
        bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            isScrollable: true,
            controller: tabcontrol,
            tabs: [
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
          //  AllTabPage(),
          // Center(
          //   child: Text("All"),
          // ),
          // Center(child: Text("Rice"),),
          CustomerAllTab(),
          CustomerRiceTab(),
          CustomerSoapTab(),
          CustomerSnacksTab(),
          CustomerToothpasteTab(),
          CustomerCookingoilTab()
        ]),
      ),
    );
  }
}

class Customesearch extends SearchDelegate{
  List<String> searchterms=["Matta","Soup","Coocking Oil","Biriyani Rice"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
     return[
      IconButton(onPressed: () {
        query=' ';
      }, icon: Icon(Icons.search))
    ];
  }
  
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back));  }
  
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
 List<String> matchQury=[];
    for(String fruit in searchterms){
      if(fruit.toLowerCase().contains(query.toLowerCase())){
        matchQury.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQury.length,
      itemBuilder: (context, index) {
        var result=matchQury[index];
        return ListTile(
          title: Text(result),
        );
      },);  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
 List<String> matchQury=[];
    for(var fruit in searchterms){
      if(fruit.toLowerCase().contains(query.toLowerCase())){
        matchQury.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQury.length,
      itemBuilder: (context, index) {
        var result=matchQury[index];
        return ListTile(
          title: Text(result),
        );
      },);  }
}
