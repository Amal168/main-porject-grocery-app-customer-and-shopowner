import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class CustomerOrder extends StatefulWidget {
  final String customerid;
  final String shopid;

  CustomerOrder({super.key, required this.customerid, required this.shopid});

  @override
  State<CustomerOrder> createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder> {
  late Future<List<QueryDocumentSnapshot>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    _ordersFuture = FirebaseFirestore.instance
        .collection('orders')
        .where('user_id', isEqualTo: widget.customerid)
        .get()
        .then((snapshot) => snapshot.docs);
  }

  Future<void> _cancelOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order has been canceled.', textAlign: TextAlign.center),
        ),
      );
      setState(() {
        _loadOrders();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to cancel order: $e', textAlign: TextAlign.center),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customerid.isEmpty || widget.shopid.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Customer ID or Shop ID is missing.")),
      );
    }

    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: _ordersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text("Error loading orders.")));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(body: Center(child: Text("No orders found.")));
        }

        final orders = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text("My Orders"),
            backgroundColor: toggle2color,
            centerTitle: true,
          ),
          backgroundColor: Colors.grey.shade100,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
                final canCancel = timestamp != null &&
                    DateTime.now().difference(timestamp).inMinutes < 10;

                final total = order['total'] ?? 0;
                final deliveryType = order['delivery_type'] ?? 'Unknown';
                final status = order['status'] ?? 'Pending';
                final List<dynamic> items = order['items'] ?? [];

                return Card(
                  elevation: 8,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (canCancel)
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: listbutton,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      "Are You Sure?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    content: const Text(
                                      "Do you want to cancel this order?",
                                      textAlign: TextAlign.center,
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: toggle2color,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _cancelOrder(order.id);
                                        },
                                        child: const Text('OK',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: redbutton,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.cancel_outlined),
                              label: const Text(
                                "Cancel",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        const Text("Order Details:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Order Date:"),
                            Text(
                              timestamp != null
                                  ? DateFormat('dd MMM yyyy hh:mm a').format(timestamp)
                                  : "Unknown",
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Text("Delivery Type: $deliveryType",
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 6),
                        Text("Order Status: $status",
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 12),
                        const Text("Products:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, i) {
                            final item = items[i] as Map<String, dynamic>? ?? {};
                            final productName = item['product_name'] ?? 'N/A';
                            final price = item['price'] ?? 0;
                            final quantity = item['quantity'] ?? 1;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    productName,
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text("Qty: $quantity",
                                    style: const TextStyle(fontSize: 14)),
                                Text("₹$price",
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: toggle2color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Total:",
                                  style:
                                      TextStyle(fontSize: 14, color: Colors.white)),
                              const SizedBox(width: 10),
                              Text("₹$total",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: const Text(
                            "You will receive a message\nwhen it is completed",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
