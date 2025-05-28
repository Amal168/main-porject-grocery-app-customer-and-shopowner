import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderReceavedList.dart';

class Orderreceved extends StatelessWidget {
  const Orderreceved({super.key});

  final List<String> received = const ["Sithara", "Arjune", "Pokiry", "Vishal", "Sehal"];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: received.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Orderreceavedlist())),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                received[index],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            ),
          ),
        );
      },
    );
  }
}
