import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class CustomerAllTab extends StatefulWidget {
  final String category;
  final String shopid;
  final String searchQuery;

  const CustomerAllTab({
    super.key,
    required this.category,
    required this.shopid,
    required this.searchQuery,
  });

  @override
  State<CustomerAllTab> createState() => _CustomerAllTabState();
}

class _CustomerAllTabState extends State<CustomerAllTab> {
  int selectedIndex = -1;
  String selectedType = 'All';
  List<String> typeList = ['All'];

  @override
  void initState() {
    super.initState();
    _fetchTypes();
  }

  Future<void> _fetchTypes() async {
    Query query = FirebaseFirestore.instance
        .collection('products')
        .where('user_id', isEqualTo: widget.shopid);

    if (widget.category != 'All') {
      query = query.where('Category', isEqualTo: widget.category);
    }

    final snapshot = await query.get();
    final types = snapshot.docs
        .map((doc) => (doc['type'] as String?)?.trim())
        .where((type) => type != null && type.isNotEmpty)
        .toSet()
        .cast<String>()
        .toList();

    setState(() {
      typeList = ['All', ...types];
    });
  }

  Stream<QuerySnapshot> getProductStream() {
    Query query = FirebaseFirestore.instance
        .collection('products')
        .where('user_id', isEqualTo: widget.shopid);

    if (widget.category != 'All') {
      query = query.where('Category', isEqualTo: widget.category);
    }

    if (selectedType != 'All') {
      query = query.where('type', isEqualTo: selectedType);
    }

    return query.snapshots();
  }

  Future<void> updateProductStock(String productId, int newStock) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({'stock': newStock});
  }

  Future<void> addToCart(Map<String, dynamic> product) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('cart');

    final productId = product['product_id'];

    final existing = await cartRef.where('product_id', isEqualTo: productId).get();

    if (existing.docs.isNotEmpty) {
      final doc = existing.docs.first;
      await cartRef.doc(doc.id).update({
        'quantity': FieldValue.increment(1),
      });
    } else {
      await cartRef.add({
        'product_id': productId,
        'product_name': product['product_name'],
        'image': product['image'],
        'unit': product['unit'],
        'price': product['product_price'],
        'quantity': 1,
        'shop_id': widget.shopid,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    // Update stock after adding to cart
    int currentStock = product['stock'] ?? 0;
    if (currentStock > 0) {
      int updatedStock = currentStock - 1;
      await updateProductStock(productId, updatedStock);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (typeList.length > 1)
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: typeList.map((type) {
                final isSelected = selectedType == type;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedType = type;
                        selectedIndex = -1;
                      });
                    },
                    selectedColor: toggle2color,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                );
              }).toList(),
            ),
          ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: getProductStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text('No products found.'));
              }

              final products = snapshot.data!.docs.where((doc) {
                final name = (doc['product_name'] ?? '').toString().toLowerCase();
                return name.contains(widget.searchQuery.toLowerCase());
              }).toList();

              if (products.isEmpty) {
                return const Center(child: Text('No products match your search.'));
              }

              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (context, index) {
                  final product = products[index].data() as Map<String, dynamic>;

                  String name = product['product_name'] ?? 'No Name';
                  String image = product['image'] ?? '';
                  int stock = product['stock'] ?? 0;
                  String unit = product['unit'] ?? '';
                  String price = product['product_price']?.toString() ?? '0';
                  bool isLowStock = stock < 4;
                  bool isSelected = selectedIndex == index;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: image.isNotEmpty
                                ? Image.network(
                                    image,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/dummy image.jpeg',
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Only $stock Left",
                            style: TextStyle(
                              color: isLowStock ? redbutton : toglecolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "$unit - ₹$price",
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSelected ? toggle2color : Colors.white,
                                foregroundColor: isSelected ? Colors.white : Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: toggle2color),
                                ),
                              ),
                              onPressed: () {
                                addToCart(product);
                              },
                              child: Text(isSelected ? "Selected" : "Select"),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
