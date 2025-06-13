import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class Ordersendlist extends StatefulWidget {
  const Ordersendlist({super.key});

  @override
  State<Ordersendlist> createState() => _OrderreceavedlistState();
}

class _OrderreceavedlistState extends State<Ordersendlist> {
  final List<int> itemCounts = List.generate(4, (index) => 1);
  String radioButton = "1";
  final int discount = 0;

  int get subtotal => itemCounts.fold(0, (sum, count) => sum + (count * 20));
  int get deliveryfee => radioButton == "1" ? 0 : 10;
  int get total => subtotal + deliveryfee - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_return),
        ),
        title: const Text(
          "Your Cart",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        elevation: 6,
        backgroundColor: toggle2color,
        shadowColor: Colors.black54,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.separated(
          itemCount: itemCounts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "assets/images.jpg",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 90,
                        height: 90,
                        color: Colors.grey.shade300,
                        child: Icon(Icons.image_not_supported,
                            color: Colors.grey.shade600, size: 40),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Name",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "1 Piece",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${itemCounts[index] * 20} Rs",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: toggle2color),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Colors.grey.shade400),
                            ),
                            child: Text(
                              "Qty: ${itemCounts[index]}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 4,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _OrderreceavedlistState.buildPriceRow("Subtotal", "$subtotal Rs"),
              _OrderreceavedlistState.buildPriceRow("Delivery Fee", "$deliveryfee Rs"),
              _OrderreceavedlistState.buildPriceRow("Discount", "$discount Rs"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _OrderreceavedlistState.buildRadioButton("Pickup", "1", radioButton, (newValue) {
                    setState(() {
                      radioButton = newValue;
                    });
                  }),
                  const SizedBox(width: 40),
                  _OrderreceavedlistState.buildRadioButton("Delivery", "2", radioButton, (newValue) {
                    setState(() {
                      radioButton = newValue;
                    });
                  }),
                ],
              ),
              const SizedBox(height: 20),
              MaterialButton(
                elevation: 12.0,
                minWidth: double.infinity,
                height: 50,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "A message will be sent to the customer about the order being completed"),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Total:",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(width: 12),
                    Text("$total Rs",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(width: 12),
                    const Icon(Icons.send, color: Colors.black, size: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inknut_Antiqua")),
          Text(value,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: toggle2color)),
        ],
      ),
    );
  }

  static Widget buildRadioButton(String title, String value, String groupValue, Function(String) onChanged) {
    return Row(
      children: [
        Radio<String>(
          activeColor: toggle2color,
          value: value,
          groupValue: groupValue,
          onChanged: (newValue) => onChanged(newValue!),
        ),
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
