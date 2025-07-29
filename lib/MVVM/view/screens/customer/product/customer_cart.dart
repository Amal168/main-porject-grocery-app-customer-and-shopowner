import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class CustomerCart extends StatefulWidget {
  final String shopid;
  CustomerCart({super.key, required this.shopid});

  @override
  State<CustomerCart> createState() => _CustomerCartState();
}

class _CustomerCartState extends State<CustomerCart> {
  String radioButton = "1";
  final int discount = 0;
  final currentUser = FirebaseAuth.instance.currentUser;

  Stream<QuerySnapshot> getCartStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .collection('cart')
        .snapshots();
  }

  Future<void> updateProductStock(String productId, int increment) async {
    final productRef = FirebaseFirestore.instance.collection('products').doc(productId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(productRef);
      if (!snapshot.exists) return;

      final currentStock = snapshot.get('stock') ?? 0;
      final newStock = currentStock + increment; // increment can be negative

      if (newStock >= 0) {
        transaction.update(productRef, {'stock': newStock});
      }
    });
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: getCartStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs;

          if (cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty."));
          }

          int subtotal = 0;
          for (var doc in cartItems) {
            final item = doc.data() as Map<String, dynamic>;

            final priceRaw = item['price'];
            num priceNum = 0;
            if (priceRaw is int || priceRaw is double) {
              priceNum = priceRaw;
            } else if (priceRaw is String) {
              priceNum = num.tryParse(priceRaw) ?? 0;
            }

            final quantityRaw = item['quantity'];
            int quantityNum = 1;
            if (quantityRaw is int) {
              quantityNum = quantityRaw;
            } else if (quantityRaw is String) {
              quantityNum = int.tryParse(quantityRaw) ?? 1;
            }

            subtotal += (priceNum * quantityNum).toInt();
          }

          final deliveryFee = radioButton == "1" ? 0 : 10;
          final total = subtotal + deliveryFee - discount;

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final doc = cartItems[index];
                    final item = doc.data() as Map<String, dynamic>;

                    final quantityRaw = item['quantity'];
                    final count = (quantityRaw is int)
                        ? quantityRaw
                        : (int.tryParse(quantityRaw?.toString() ?? '') ?? 1);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: (item['image'] != null &&
                                    (item['image'] as String).isNotEmpty)
                                ? Image.network(
                                    item['image'],
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: Colors.grey[300],
                                      width: 90,
                                      height: 90,
                                      child:
                                          const Icon(Icons.image_not_supported),
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey[300],
                                    width: 90,
                                    height: 90,
                                    child:
                                        const Icon(Icons.image_not_supported),
                                  ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['product_name'] ?? 'No Name',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800)),
                                    const SizedBox(height: 6),
                                    Text("${item['unit'] ?? ''}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600)),
                                    const SizedBox(height: 8),
                                    Text("₹${item['price'] ?? 0}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: toggle2color)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final quantityToReturn = doc.get('quantity') ?? 1;
                                      final productId = doc.get('product_id');
                                      await doc.reference.delete();

                                      // Return stock back
                                      await updateProductStock(productId, quantityToReturn);
                                    },
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(Icons.close,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (count > 1) {
                                            await doc.reference.update({
                                              'quantity': FieldValue.increment(-1),
                                            });
                                            await updateProductStock(doc['product_id'], 1);
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Icon(Icons.remove, size: 28),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                        child: Text(count.toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.8)),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // Check product stock before incrementing quantity
                                          final productDoc = await FirebaseFirestore.instance
                                              .collection('products')
                                              .doc(doc['product_id'])
                                              .get();

                                          final currentStock = productDoc.get('stock') ?? 0;

                                          if (currentStock > 0) {
                                            await doc.reference.update({
                                              'quantity': FieldValue.increment(1),
                                            });
                                            await updateProductStock(doc['product_id'], -1);
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('No more stock available')),
                                            );
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: toggle2color,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Icon(Icons.add_box,
                                              size: 28, color: Colors.white),
                                        ),
                                      ),
                                    ],
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
              buildCartSummary(subtotal, deliveryFee, total),
            ],
          );
        },
      ),
    );
  }

  Widget buildCartSummary(int subtotal, int deliveryFee, int total) {
    return Container(
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
            buildPriceRow("Subtotal", "₹$subtotal"),
            buildPriceRow("Delivery Fee", "₹$deliveryFee"),
            buildPriceRow("Discount", "₹$discount"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildRadioButton("Pickup", "1"),
                const SizedBox(width: 40),
                buildRadioButton("Delivery", "2"),
              ],
            ),
            const SizedBox(height: 20),
            MaterialButton(
              elevation: 12.0,
              minWidth: double.infinity,
              height: 50,
              color: toggle2color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () async {
                final cartRef = FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser!.uid)
                    .collection('cart');

                final snapshot = await cartRef.get();

                // Extract cart items
                List<Map<String, dynamic>> items = snapshot.docs.map((doc) {
                  final data = doc.data();
                  return {
                    'product_name': data['product_name'] ?? '',
                    'price': data['price'] ?? 0,
                    'quantity': data['quantity'] ?? 1,
                    'unit': data['unit'] ?? '',
                    'image': data['image'] ?? '',
                  };
                }).toList();

                // Place order
                final userDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser!.uid)
                    .get();

                final customerName = userDoc.data()?['name'] ?? 'No Name';

                await FirebaseFirestore.instance.collection('orders').add({
                  'user_id': currentUser?.uid,
                  'customerName': customerName,
                  'status': 'pending',
                  'delivery_type': radioButton == "1" ? "Pickup" : "Delivery",
                  'total': total,
                  'timestamp': FieldValue.serverTimestamp(),
                  'shopid': widget.shopid,
                  'items': items,
                  'subtotal': subtotal,
                  'delivery': deliveryFee,
                  'cartuid': FirebaseFirestore.instance.collection('orders').doc().id
                });

                // Clear cart
                for (var doc in snapshot.docs) {
                  await doc.reference.delete();
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully!")),
                );
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "₹$total",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.send, color: Colors.white, size: 22),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget buildRadioButton(String title, String value) {
    return Row(
      children: [
        Radio<String>(
          activeColor: toggle2color,
          value: value,
          groupValue: radioButton,
          onChanged: (newValue) {
            setState(() {
              radioButton = newValue!;
            });
          },
        ),
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
