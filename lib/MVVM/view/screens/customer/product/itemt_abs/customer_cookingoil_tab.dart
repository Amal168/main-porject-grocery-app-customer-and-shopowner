import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

final List<Map<String, dynamic>> CookingoilList = [
  {"ProductName": "PacketOil", "Category": "packet oil", "ShopPrice": 5, "Weight": "1kg", "Rupees": "100"},
  {"ProductName": "PacketOil", "Category": "packet oil", "ShopPrice": 7, "Weight": "2kg", "Rupees": "200"},
  {"ProductName": "PacketOil", "Category": "packet oil", "ShopPrice": 10, "Weight": "1kg", "Rupees": "100"},
  {"ProductName": "BottleOil", "Category": "bottle oil", "ShopPrice": 4, "Weight": "1kg", "Rupees": "100"},
  {"ProductName": "BottleOil", "Category": "bottle oil", "ShopPrice": 8, "Weight": "1kg", "Rupees": "100"},
  {"ProductName": "LooseOil", "Category": "loose oil", "ShopPrice": 1, "Weight": "1kg", "Rupees": "100"},
];

class CustomerCookingoilTab extends StatefulWidget {
  @override
  State<CustomerCookingoilTab> createState() => _CustomerCookingoilTabState();
}

class _CustomerCookingoilTabState extends State<CustomerCookingoilTab> {
  int selectedIndex = 0;

  List<String> cookingoil = ["All", "packet oil", "bottle oil", "loose oil"];

  List<Map<String, dynamic>> getFilteredList() {
    if (selectedIndex == 0) return CookingoilList;
    return CookingoilList.where((item) => item["Category"] == cookingoil[selectedIndex]).toList();
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
            itemCount: cookingoil.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  label: Text(cookingoil[index]),
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
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
