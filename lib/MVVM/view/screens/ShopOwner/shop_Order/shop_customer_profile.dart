import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/Commonlogin.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/CommonCommentRating.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderReceavedList.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/Customer_Profile.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/edit_customer_profile.dart';

class ShopCustomerProfile extends StatefulWidget {
  const ShopCustomerProfile({super.key});

  @override
  State<ShopCustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<ShopCustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Customer Profile",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: toggle2color,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(Firebaseothservices().uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!.data();

            if (data == null) {
              return Center(
                child: Text('No user data'),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Profile Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [toggle2color.withOpacity(0.9), toggle2color],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    backgroundImage: AssetImage(
                                        "assets/dummy profile photo.jpg"),
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Customer Name",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white70),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => EditCustomerProfile()));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Info Section
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        InfoTile(label: "Mobile Number", value: "1234567890"),
                        Divider(),
                        InfoTile(label: "Place", value: "Your City"),
                        Divider(),
                        InfoTile(label: "Email", value: "Customer@gmail.com"),
                        Divider(),
                        InfoTile(
                            label: "Location", value: "Street XYZ, Area ABC"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  ButtonTile(
                    icon: Icons.arrow_back_ios_new_outlined,
                    label: "Back",
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Orderreceavedlist()));
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          }),
    );
  }
}


// Button row widget
