import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class CustomerCart extends StatefulWidget {
  const CustomerCart({super.key});

  @override
  State<CustomerCart> createState() => _CustomerCartState();
}

class _CustomerCartState extends State<CustomerCart> {
  List<int> itemCounts = List.generate(3, (index) => 1);
  String? radioButton = "1";
  int deliveryFee = 0;
  late int discount;

  int get subtotal => itemCounts.fold(0, (sum, count) => sum + (count * 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_return),
        ),
        title: const Text("List",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: itemCounts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images.jpg",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.image_not_supported,
                        color: Colors.grey.shade600),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Product Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const Text("1 Piece"),
                      Text("${itemCounts[index] * 20} Rs"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          // itemCounts[index].
                        },
                        icon: Icon(Icons.close),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (itemCounts[index] > 1) itemCounts[index]--;
                              });
                            },
                            icon: const Icon(Icons.remove, size: 30),
                          ),
                          Text("${itemCounts[index]}",
                              style: const TextStyle(fontSize: 16)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                itemCounts[index]++;
                              });
                            },
                            icon: const Icon(Icons.add_box, size: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildPriceRow("Subtotal", "${subtotal} Rs"),
                buildPriceRow("Delivery Fee", "$deliveryFee Rs"),
                buildPriceRow("Discount",
                    "${radioButton == "1" ? discount = 0 : discount = 2} Rs"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildRadioButton("Pickup", "1"),
                    buildRadioButton("Delivery", "2"),
                  ],
                ),
                MaterialButton(
                  elevation: 10.0,
                  minWidth: double.infinity,
                  height: 40,
                  color: toggle2color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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
                    children: [
                      const Text("Total:",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        width: 10,
                      ),
                      Text("${subtotal + deliveryFee - discount} Rs",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        width: 200,
                      ),
                      const Icon(Icons.send, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inknut_Antiqua")),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget buildRadioButton(String title, String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: radioButton,
          onChanged: (newValue) {
            setState(() {
              radioButton = newValue;
            });
          },
        ),
        Text(title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
