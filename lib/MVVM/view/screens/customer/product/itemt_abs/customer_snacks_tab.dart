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
  },
  {
    "ProductName": "Ice Cream",
    "Category": "Ice Cream",
    "ShopPrice": 16,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
    "ProductName": "Ice Cream",
    "Category": "Ice Cream",
    "ShopPrice": 5,
    "Weight": "1kg",
    "Rupees": "100"
  },
  {
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
  List snacks = [
    "All",
    "Biscute",
    "Packet Snacks",
    "Loose Snaks",
    "Laces",
    "Ice Cream"
  ];

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
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: snacks.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  label: Text(snacks[index]),
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
                    );
                  },
                ),
        ),
      ],
    );
  }
}
