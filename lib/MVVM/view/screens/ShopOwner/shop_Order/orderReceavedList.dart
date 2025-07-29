import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/Shop_Customer_Chat.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/shop_customer_profile.dart';

class Orderreceavedlist extends StatefulWidget {
  final String? customerid;

  const Orderreceavedlist({super.key, this.customerid});

  @override
  State<Orderreceavedlist> createState() => _OrderreceavedlistState();
}

class _OrderreceavedlistState extends State<Orderreceavedlist> {
  int manualDiscount = 0;
  final TextEditingController discountController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customerid == null) {
      return const Center(child: Text("No customer ID provided."));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('user_id', isEqualTo: widget.customerid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        final orders = snapshot.data?.docs ?? [];

        List<Map<String, dynamic>> allItems = [];
        int subtotal = 0;
        int deliveryFee = 0;

        for (var order in orders) {
          final items = order['items'] as List<dynamic>? ?? [];
          allItems.addAll(items.map((e) => Map<String, dynamic>.from(e)));

          subtotal += int.tryParse(order['subtotal'].toString()) ?? 0;
          deliveryFee += int.tryParse(order['delivery'].toString()) ?? 0;
        }

        final adjustedTotal = subtotal + deliveryFee - manualDiscount;

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.keyboard_return),
            ),
            title: const Text(
              "Customer Order",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.1),
            ),
            centerTitle: true,
            elevation: 6,
            backgroundColor: toggle2color,
            shadowColor: Colors.black54,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  ShopCustomerProfile(customerid: widget.customerid!)),
                  );
                },
                icon: const Icon(Icons.person),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ShopCustomerChat(
                        receiverId: widget.customerid!,
                        senderId: FirebaseAuth.instance.currentUser!.uid,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.chat),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: allItems.isEmpty
                ? const Center(child: Text("No items in this order."))
                : ListView.separated(
                    itemCount: allItems.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = allItems[index];
                      final productName = item['product_name'] ?? 'No Name';
                      final price = int.tryParse(item['price'].toString()) ?? 0;
                      final quantity = int.tryParse(item['quantity'].toString()) ?? 1;
                      final image = item['image'] ?? '';

                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: image.toString().isNotEmpty
                                  ? Image.network(
                                      image,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Container(
                                        color: Colors.grey[300],
                                        width: 90,
                                        height: 90,
                                        child: const Icon(Icons.image_not_supported),
                                      ),
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      width: 90,
                                      height: 90,
                                      child: const Icon(Icons.image_not_supported),
                                    ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "$quantity piece(s)",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey.shade600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "₹${price * quantity}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: toggle2color),
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
                  TextFormField(
                    controller: discountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter Discount (₹)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(
                        const Duration(milliseconds: 400),
                        () {
                          setState(() {
                            manualDiscount = int.tryParse(value) ?? 0;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  buildPriceRow("Subtotal", "₹$subtotal"),
                  buildPriceRow("Delivery Fee", "₹$deliveryFee"),
                  buildPriceRow("Discount", "₹$manualDiscount"),
                  const SizedBox(height: 20),
                  MaterialButton(
                    elevation: 12.0,
                    minWidth: double.infinity,
                    height: 50,
                    color: toggle2color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text("Is the order finished?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(ctx);

                                final batch = FirebaseFirestore.instance.batch();
                                for (var order in orders) {
                                  final docRef = FirebaseFirestore.instance
                                      .collection('orders')
                                      .doc(order.id);
                                  batch.update(docRef, {
                                    'status': 'Checked',
                                    'discount': manualDiscount,
                                    'total': adjustedTotal,
                                  });
                                }
                                await batch.commit();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("All orders marked as complete.")),
                                );
                                Navigator.pop(context);
                              },
                              child: const Text("Yes, it is"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Total:",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(width: 12),
                        Text("₹$adjustedTotal",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(width: 12),
                        const Icon(Icons.send, color: Colors.white, size: 22),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPriceRow(String label, String value) {
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
}
