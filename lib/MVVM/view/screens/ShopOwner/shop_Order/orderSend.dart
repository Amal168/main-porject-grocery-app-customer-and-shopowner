import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderReceavedList.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderSendList.dart';

class Ordersend extends StatelessWidget {
  const Ordersend({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('orders').where('status',isEqualTo: 'Checked').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        final docs = snapshot.data?.docs ?? [];

        final customerNames = docs
            .map((doc) => doc['customerName'] ?? '') 
            .where((name) => name.isNotEmpty)
            .toSet()
            .toList();

        final customerIds = docs
            .map((doc) => doc['user_id'] ?? '') 
            .where((id) => id.isNotEmpty)
            .toSet()
            .toList();

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: customerNames.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Ordersendlist(
                    customerid: customerIds[index],
                  ),
                ),
              ),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    customerNames[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
