import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

final List<Map<String, dynamic>> pasteList = [
  {
    "ProductName": "Pastes",
    "Category": "Pastes",
    "ShopPrice": 5,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "Pastes",
    "Category": "Pastes",
    "ShopPrice": 7,
    "Weight": "2kg",
    "Rupees": "200"
  },
  {
    "ProductName": "Pastes",
    "Category": "Pastes",
    "ShopPrice": 10,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "brushes",
    "Category": "brushes",
    "ShopPrice": 4,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "brushes",
    "Category": "brushes",
    "ShopPrice": 8,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "mouth Wash",
    "Category": "mouth Wash",
    "ShopPrice": 12,
    "Weight": "1kg",
    "Rupees": "100"
  },
   {
    "ProductName": "toungh cleaner",
    "Category": "toungh cleaner",
    "ShopPrice": 11,
    "Weight": "1kg",
    "Rupees": "100"
  }, {
    "ProductName": "toungh cleaner",
    "Category": "toungh cleaner",
    "ShopPrice": 16,
    "Weight": "1kg",
    "Rupees": "100"
  }, {
    "ProductName": "toungh cleaner",
    "Category": "toungh cleaner",
    "ShopPrice": 5,
    "Weight": "1kg",
    "Rupees": "100"
  }, {
    "ProductName": "toungh cleaner",
    "Category": "toungh cleaner",
    "ShopPrice": 10,
    "Weight": "1kg",
    "Rupees": "100"
  },
];

class CustomerToothpasteTab extends StatefulWidget {
  @override
  State<CustomerToothpasteTab> createState() => _CustomerToothpasteTabState();
}

class _CustomerToothpasteTabState extends State<CustomerToothpasteTab> {
  int selectedIndex = 0;
  List paste = ["All","Pastes","brushes","mouth Wash","toungh cleaner"];


  List<Map<String, dynamic>> getFilteredList() {
    if (selectedIndex == 0) return pasteList;
    return pasteList.where((item) => item["Category"] == paste[selectedIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = getFilteredList();

    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: paste.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  label: Text(paste[index]),
                  selected: isSelected,
                  selectedColor: toggle2color,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                  onSelected: (_) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: filteredList.isEmpty
              ? const Center(child: Text("No data available"))
              : GridView.builder(
                  itemCount: filteredList.length,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 270,
                  ),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    final isLowStock = item["ShopPrice"] < 5;

                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/571332.jpg",
                                width: double.infinity,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item["ProductName"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Only ${item["ShopPrice"]} left",
                              style: TextStyle(
                                fontSize: 14,
                                color: isLowStock ? Colors.red : toggle2color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${item['Weight']} • ${item['Rupees']} Rs",
                              style: const TextStyle(fontSize: 14),
                            ),
                            // const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: toggle2color,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Select"),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
