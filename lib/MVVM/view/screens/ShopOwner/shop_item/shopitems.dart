import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/itemt_abs/all_tab.dart';
import 'addproduct.dart';

class Shopitems extends StatefulWidget {
  const Shopitems({super.key});

  @override
  State<Shopitems> createState() => _ShopitemsState();
}

class _ShopitemsState extends State<Shopitems> with TickerProviderStateMixin {
  TabController? _tabController;
  List<String> _categories = ['All'];

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text("User not authenticated"));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .where('user_id', isEqualTo: currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final docs = snapshot.data?.docs ?? [];

        final allCategories = docs
            .map((doc) => doc['Category'] as String?)
            .where((cat) => cat != null && cat.trim().isNotEmpty)
            .toSet()
            .cast<String>()
            .toList();

        _categories = ['All', ...allCategories];
        _tabController = TabController(length: _categories.length, vsync: this);

        return SafeArea(
          child: Column(
            children: [
              // Search and Add Button
              Container(
                color: toggle2color,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add_shopping_cart_sharp),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Addproduct()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // TabBar
              Container(
                color: toggle2color,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.white,
                  tabs: _categories.map((cat) => Tab(text: cat)).toList(),
                ),
              ),

              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _categories
                      .map((cat) => ShopItemsTabView(category: cat))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

