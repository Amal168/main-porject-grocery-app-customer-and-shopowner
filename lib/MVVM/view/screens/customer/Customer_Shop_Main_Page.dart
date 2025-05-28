import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/slider.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/Customer_Profile.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/customer_Bottom.dart';

class CustomerShopMainPage extends StatefulWidget {
  const CustomerShopMainPage({super.key});

  @override
  State<CustomerShopMainPage> createState() => _CustomerShopMainPageState();
}

class _CustomerShopMainPageState extends State<CustomerShopMainPage> {
  final TextEditingController _search = TextEditingController();
  final List<Map<String, dynamic>> customerShopNear = [
    {"ShopName": "Devakaran's Shop", "ShopPlace": "Dayankave", "PhoneNumber": "3254589247"},
    {"ShopName": "milma", "ShopPlace": "Dayankave", "PhoneNumber": "1234567890"},
    {"ShopName": "Athul", "ShopPlace": "Mathotezham", "PhoneNumber": "3692581407"},
    {"ShopName": "Almas", "ShopPlace": "Mathotezham", "PhoneNumber": "1593574862"},
    {"ShopName": "mrithul's Shop", "ShopPlace": "K T thazham", "PhoneNumber": "1237890456"}
  ];
  final List<Map<String, dynamic>> customerShopOther = [
    {"ShopName": "Devakaran's Shop", "ShopPlace": "Potamil", "PhoneNumber": "3254589247"},
    {"ShopName": "milma", "ShopPlace": "Potamil", "PhoneNumber": "1234567890"},
    {"ShopName": "Athul", "ShopPlace": "Kachilate", "PhoneNumber": "3692581407"},
    {"ShopName": "Almas", "ShopPlace": "Pala", "PhoneNumber": "1593574862"},
    {"ShopName": "mrithul's Shop", "ShopPlace": "Kachilate", "PhoneNumber": "1237890456"},
    {"ShopName": "milma", "ShopPlace": "PalKambani", "PhoneNumber": "1234567890"},
    {"ShopName": "Athul", "ShopPlace": "PalKambani", "PhoneNumber": "3692581407"},
    {"ShopName": "Almas", "ShopPlace": "Palazhi", "PhoneNumber": "1593574862"},
    {"ShopName": "mrithul's Shop", "ShopPlace": "Pala", "PhoneNumber": "1237890456"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TextFormField(
          controller: _search,
          decoration: InputDecoration(
            hintText: "Search Your Shop",
            prefixIcon: const Icon(Icons.search, size: 24),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerProfile()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/dummy profile photo.jpg"),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Sliderpage(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Nearest Shops",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: customerShopNear.length,
                  itemBuilder: (context, index) {
                    final shop = customerShopNear[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerBottom())),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/571332.jpg",
                                  height: 80,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(shop["ShopName"], style: const TextStyle(fontWeight: FontWeight.w600)),
                              Text(shop["ShopPlace"], style: const TextStyle(fontSize: 13, color: Colors.grey)),
                              Text(shop["PhoneNumber"], style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Other Shops",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: customerShopOther.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final shop = customerShopOther[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerBottom())),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/571332.jpg",
                              height: 70,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(shop["ShopName"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(shop["ShopPlace"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          Text(shop["PhoneNumber"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
