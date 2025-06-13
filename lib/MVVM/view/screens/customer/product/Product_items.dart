import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/Shop_Customer_Chat.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/customer_cart.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/product/Customer_all_tab.dart';

class ProductItems extends StatefulWidget {
  final String shopid;

  const ProductItems({super.key, required this.shopid});

  @override
  State<ProductItems> createState() => _ProductItemsState();
}

class _ProductItemsState extends State<ProductItems> with TickerProviderStateMixin {
  TabController? _tabController;
  List<String> _categories = ['All'];

  void _updateTabController(List<String> categories) {
    _tabController?.dispose();
    _tabController = TabController(length: categories.length, vsync: this);
  }

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
          .where('user_id', isEqualTo: widget.shopid)
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

        final newCategories = ['All', ...allCategories];

        if (_tabController == null || _categories.join() != newCategories.join()) {
          _categories = newCategories;
          _updateTabController(_categories);
        }

        return SafeArea(
          child: Column(
            children: [
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
                    _buildIconButton(
                      icon: Icons.chat_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ShopCustomerChat()),
                        );
                      },
                    ),
                    const SizedBox(width: 5),
                    _buildIconButton(
                      icon: Icons.shopping_cart_sharp,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CustomerCart()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: toggle2color,
                child: _tabController == null
                    ? const SizedBox()
                    : TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        indicatorColor: Colors.white,
                        tabs: _categories.map((cat) => Tab(text: cat)).toList(),
                      ),
              ),
              Expanded(
                child: _tabController == null
                    ? const SizedBox()
                    : TabBarView(
                        controller: _tabController,
                        children: _categories
                            .map((cat) => CustomerAllTab(
                                  category: cat,
                                  shopid: widget.shopid,
                                ))
                            .toList(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onTap,
      ),
    );
  }
}
