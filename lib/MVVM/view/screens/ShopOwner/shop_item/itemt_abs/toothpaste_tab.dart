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
  },
  {
    "ProductName": "toungh cleaner",
    "Category": "toungh cleaner",
    "ShopPrice": 16,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "toungh cleaner",
    "Category": "toungh cleaner",
    "ShopPrice": 5,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "toungh cleaner",
    "Category": "toungh cleaner",
    "ShopPrice": 10,
    "Weight": "1kg",
    "Rupees": "100"
  },
];

class ToothpasteTab extends StatefulWidget {
  @override
  State<ToothpasteTab> createState() => _ToothpasteTabState();
}

class _ToothpasteTabState extends State<ToothpasteTab> {
  final stocknumber = TextEditingController();
  int selectedIndex = 0;
  List paste = ["All", "Pastes", "brushes", "mouth Wash", "toungh cleaner"];

  List<Map<String, dynamic>> getFilteredList() {
    if (selectedIndex == 0) return pasteList;
    return pasteList
        .where((item) => item["Category"] == paste[selectedIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = getFilteredList();

    return Column(
      children: [
        SizedBox(
          height: 50,
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
                  onSelected: (_) => setState(() => selectedIndex = index),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  selectedColor: toggle2color,
                  shape: StadiumBorder(
                    side: BorderSide(color: toggle2color),
                  ),
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
                  padding: const EdgeInsets.all(10),
                  itemCount: filteredList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    final isLowStock = item["ShopPrice"] < 5;

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "assets/tootpaste.jpeg",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item["ProductName"],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Only ${item["ShopPrice"]} left",
                            style: TextStyle(
                              color: isLowStock ? redbutton : toggle2color,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${item['Weight']} • ${item['Rupees']} Rs",
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.inventory, size: 16, color: Colors.white),
                                  label: const Text("Restock",
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: button1,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Restock Product"),
                                        content: TextFormField(
                                          controller: stocknumber,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(labelText: "Stock Number"),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text("Cancel")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                // TODO: Handle restocking logic
                                              },
                                              child: const Text("OK")),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.delete_outline, size: 16, color: Colors.white),
                                  label: const Text("Delete",
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: button2,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Delete Product"),
                                        content: const Text("Are you sure you want to delete this product?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text("Cancel")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                // TODO: Handle delete logic
                                              },
                                              child: const Text("Delete")),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
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
