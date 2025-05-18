import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

final List<Map<String, dynamic>> SnacksList = [
  {
    "ProductName": "Biscute",
    "Category": "Biscute",
    "ShopPrice": 5,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "Biscute",
    "Category": "Biscute",
    "ShopPrice": 7,
    "Weight": "2kg",
    "Rupees": "200"
  },
  {
    "ProductName": "Packet Snacks",
    "Category": "Packet Snacks",
    "ShopPrice": 10,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "Packet Snacks",
    "Category": "Packet Snacks",
    "ShopPrice": 4,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "Packet Snacks",
    "Category": "Packet Snacks",
    "ShopPrice": 8,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "Laces",
    "Category": "Laces",
    "ShopPrice": 12,
    "Weight": "1kg",
    "Rupees": "100"
  },
   {
    "ProductName": "Laces",
    "Category": "Laces",
    "ShopPrice": 11,
    "Weight": "1kg",
    "Rupees": "100"
  }, {
    "ProductName": "Ice Cream",
    "Category": "Ice Cream",
    "ShopPrice": 16,
    "Weight": "1kg",
    "Rupees": "100"
  }, {
    "ProductName": "Ice Cream",
    "Category": "Ice Cream",
    "ShopPrice": 5,
    "Weight": "1kg",
    "Rupees": "100"
  }, {
    "ProductName": "Ice Cream",
    "Category": "Ice Cream",
    "ShopPrice": 10,
    "Weight": "1kg",
    "Rupees": "100"
  },
];

class CustomerSnacksTab extends StatefulWidget {
  @override
  State<CustomerSnacksTab> createState() => _CustomerSnacksTabState();
}

class _CustomerSnacksTabState extends State<CustomerSnacksTab> {
  int selectedIndex = 0;
    List snacks = ["All","Biscute","Packet Snacks","Loose Snaks","Laces","Ice Cream"];


  List<Map<String, dynamic>> getFilteredList() {
    if (selectedIndex == 0) return SnacksList;
    return SnacksList.where((item) => item["Category"] == snacks[selectedIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = getFilteredList();

    return Column(
      children: [
        Card(
          elevation: 10,
          child: Container(
            height: 40,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black26)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snacks.length,
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Text(
                    snacks[index],
                    style: TextStyle(
                      color:
                          selectedIndex == index ? toggle2color : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: filteredList.isEmpty
              ? Center(child: Text("No data available"))
              : GridView.builder(
                  itemCount: filteredList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 3,
                    mainAxisExtent: 370,
                  ),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            width: 118,
                            height: 121,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/571332.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            // Add image here if needed
                          ),
                          SizedBox(height: 10),
                          Text(
                            item["ProductName"],
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Only ${item["ShopPrice"]} Left",
                            style: TextStyle(
                                fontSize: 15,
                                color: item["ShopPrice"] < 5
                                    ? Colors.red
                                    : toggle2color),
                          ),
                          SizedBox(height: 10),
                          Text("${item['Weight']} ${item['Rupees']}Rs",
                              style: TextStyle(fontSize: 15)),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: toggle2color,
                            ),
                            onPressed: () {},
                            child: Text(
                              "Select",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
