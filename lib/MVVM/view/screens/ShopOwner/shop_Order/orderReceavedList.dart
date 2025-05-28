import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/Shop_Customer_Chat.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/shop_customer_profile.dart';

class Orderreceavedlist extends StatefulWidget {
  const Orderreceavedlist({super.key});

  @override
  State<Orderreceavedlist> createState() => _OrderreceavedlistState();
}

class _OrderreceavedlistState extends State<Orderreceavedlist> {
  final int itemCount = 3;
  late List<bool> checkedValues;

  String radiobutton = '1';

  final TextEditingController _subtotal = TextEditingController(text: "40.00");
  final TextEditingController _deliveryFee =
      TextEditingController(text: "2.00");
  final TextEditingController _discount = TextEditingController(text: "0.00");

  @override
  void initState() {
    super.initState();
    checkedValues = List.generate(itemCount, (_) => false);
    _subtotal.addListener(_updateTotal);
    _deliveryFee.addListener(_updateTotal);
    _discount.addListener(_updateTotal);
  }

  @override
  void dispose() {
    _subtotal.removeListener(_updateTotal);
    _deliveryFee.removeListener(_updateTotal);
    _discount.removeListener(_updateTotal);
    _subtotal.dispose();
    _deliveryFee.dispose();
    _discount.dispose();
    super.dispose();
  }

  void _updateTotal() => setState(() {});

  double calculateTotal() {
    final subtotal = double.tryParse(_subtotal.text.trim()) ?? 0.0;
    final deliveryFee = double.tryParse(_deliveryFee.text.trim()) ?? 0.0;
    final discount = double.tryParse(_discount.text.trim()) ?? 0.0;
    return subtotal + deliveryFee - discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: toggle2color,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Order Details",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ShopCustomerChat()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ShopCustomerProfile()),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images.jpg",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Product Name",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("1 Piece",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        Text("20 Rs", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  Checkbox(
                    value: checkedValues[index],
                    onChanged: (value) {
                      setState(() {
                        checkedValues[index] = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInputRow("Subtotal", _subtotal),
            const SizedBox(height: 10),
            _buildInputRow("Delivery Fee", _deliveryFee),
            const SizedBox(height: 10),
            _buildInputRow("Discount", _discount),
            const SizedBox(height: 15),
            Row(
              children: [
                Radio<String>(
                  value: '1',
                  groupValue: radiobutton,
                  onChanged: (value) {
                    setState(() {
                      radiobutton = value!;
                      _deliveryFee.text = "2.00";
                    });
                  },
                ),
                const Text("Delivery"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: '2',
                  groupValue: radiobutton,
                  onChanged: (value) {
                    setState(() {
                      radiobutton = value!;
                      _deliveryFee.text = "0.00";
                    });
                  },
                ),
                const Text("Pickup"),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                // backgroundColor: greenbutton,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "A message will be sent to the customer\nabout the order being completed",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.send),
              label: Text(
                "Send - ₹${calculateTotal().toStringAsFixed(2)}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputRow(String label, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: "Inknut_Antiqua")),
        SizedBox(
          width: 120,
          height: 38,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "0.00",
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
        )
      ],
    );
  }
}
