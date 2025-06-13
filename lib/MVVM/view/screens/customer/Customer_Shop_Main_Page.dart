import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String? location;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchLocation();
    _search.addListener(() {
      setState(() {
        searchText = _search.text.trim().toLowerCase();
      });
    });
  }

  Future<void> fetchLocation() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final getloc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {
      location = getloc['location'];
    });
  }

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CustomerProfile()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
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
                  width: double.infinity, height: 200, child: Sliderpage()),
              const SizedBox(height: 20),
              const Text(
                "Nearest Shops",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 190,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('location', isEqualTo: location)
                      .where('role', isEqualTo: 'ShopOwner')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No nearby shops found"));
                    }

                    final docs = snapshot.data!.docs.where((doc) {
                      final shopData = doc.data() as Map<String, dynamic>;
                      final shopName =
                          (shopData['shopname'] ?? "").toString().toLowerCase();
                      final place =
                          (shopData['location'] ?? "").toString().toLowerCase();
                      final matchesLocation = location != null &&
                          place.contains(location!.toLowerCase());
                      final matchesSearch = shopName.contains(searchText) ||
                          place.contains(searchText);
                      return matchesLocation && matchesSearch;
                    }).toList();
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final shopData =
                            docs[index].data() as Map<String, dynamic>;
                            final shopId = docs[index].id;
                            final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => CustomerBottom(shopid: shopId,customerid: currentUserId,))),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      "assets/571332.jpg",
                                      height: 90,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(shopData['shopname'] ?? "Shop",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20)),
                                  Text(shopData['phone'] ?? "",
                                      style: const TextStyle(fontSize: 12)),
                                  Text(shopData['location'] ?? "",
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('role', isEqualTo: 'ShopOwner')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('No user data found'));
                  }

                  final allShops = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    if (data['location'] == location)
                      return false; // Skip nearest
                    final shopName =
                        (data['shopname'] ?? '').toString().toLowerCase();
                    final place =
                        (data['location'] ?? '').toString().toLowerCase();
                    return shopName.contains(searchText) ||
                        place.contains(searchText);
                  }).toList();

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allShops.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 0.79,
                    ),
                    itemBuilder: (context, index) {
                      final shopData =
                          allShops[index].data() as Map<String, dynamic>;
                          final shopId = allShops[index].id;
                          final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CustomerBottom(shopid: shopId,customerid:currentUserId ,)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2)),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
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
                                const SizedBox(height: 10),
                                Text(shopData['shopname'] ?? " ",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                                         const SizedBox(height: 6),
                                Text(shopData['location'] ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                                          const SizedBox(height: 10),
                                Text(shopData['phone'] ?? "",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 11)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
