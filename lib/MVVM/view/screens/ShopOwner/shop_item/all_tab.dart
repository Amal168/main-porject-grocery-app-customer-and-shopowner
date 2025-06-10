import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class ShopItemsTabView extends StatefulWidget {
  final String category;

  const ShopItemsTabView({super.key, required this.category});

  @override
  State<ShopItemsTabView> createState() => _ShopItemsTabViewState();
}

class _ShopItemsTabViewState extends State<ShopItemsTabView> {
  List<String> _types = ['All'];
  String _selectedType = 'All';

  @override
  void initState() {
    super.initState();
    _fetchTypes();
  }

  Future<void> _fetchTypes() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      Query query = FirebaseFirestore.instance
          .collection('products')
          .where('user_id', isEqualTo: currentUser?.uid);

      if (widget.category != 'All') {
        query = query.where('Category', isEqualTo: widget.category);
      }

      final snapshot = await query.get();
      final types = snapshot.docs
          .map((doc) => doc['type'] as String?)
          .where((type) => type != null && type.trim().isNotEmpty)
          .toSet()
          .cast<String>()
          .toList();

      setState(() {
        _types = ['All', ...types];
      });
    } catch (e) {
      debugPrint("Error fetching types: $e");
    }
  }

  Stream<QuerySnapshot> _productStream() {
    final currentUser = FirebaseAuth.instance.currentUser;
    Query query = FirebaseFirestore.instance
        .collection('products')
        .where('user_id', isEqualTo: currentUser?.uid);

    if (widget.category != 'All') {
      query = query.where('Category', isEqualTo: widget.category);
    }
    if (_selectedType != 'All') {
      query = query.where('type', isEqualTo: _selectedType);
    }

    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_types.length > 1)
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _types.map((type) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: _selectedType == type,
                    onSelected: (_) {
                      setState(() => _selectedType = type);
                    },
                    selectedColor: toggle2color,
                    labelStyle: TextStyle(
                      color: _selectedType == type ? Colors.white : Colors.black,
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                );
              }).toList(),
            ),
          ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _productStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              final products = snapshot.data?.docs ?? [];
              if (products.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final data = products[index].data() as Map<String, dynamic>;
                  final stock = data['stock'] ?? 0;

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(2, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            data['image'] ?? '',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Image.asset(
                                "assets/default image.png",
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data['product_name'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Only $stock left",
                          style: TextStyle(
                            color: stock <= 5 ? redbutton : toggle2color,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${data['unit']} • ${data['product_price']} Rs",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 14),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 20,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.inventory, size: 16),
                                label: const Text("Restock", style: TextStyle(fontSize: 13)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: button1,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () => _showRestockDialog(products[index].id),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              height: 20,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.delete, size: 16),
                                label: const Text("Delete", style: TextStyle(fontSize: 13)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: button2,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                onPressed: () => _deleteProduct(products[index].id),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  void _showRestockDialog(String productId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Restock Product"),
        content: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Enter new stock"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final newStock = controller.text.trim();
              if (newStock.isEmpty) return;

              try {
                await FirebaseFirestore.instance
                    .collection('products')
                    .doc(productId)
                    .update({"stock": int.parse(newStock)});
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Stock updated")),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: $e")),
                );
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void _deleteProduct(String productId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Product"),
        content: const Text("Are you sure you want to delete this product?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance.collection('products').doc(productId).delete();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Product deleted")),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: $e")),
                );
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
