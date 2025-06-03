import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/Commonlogin.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/CommonCommentRating.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_profile/shopEditPrfile.dart';

class Shopprofile extends StatelessWidget {
  final String? shopPhotoUrl;
  final String? ownerPhotoUrl;

  const Shopprofile({super.key, this.shopPhotoUrl, this.ownerPhotoUrl});

  Widget infoCard(String label, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: toggle3color, size: 28),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget actionIconButton(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: toggle2color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        elevation: 4,
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 24),
      label: Text(label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
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
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: const Text("My Shop Profile"),
              backgroundColor: toggle2color,
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Shop Photo Banner
                  Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: shopPhotoUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(shopPhotoUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey.shade300,
                        ),
                        child: shopPhotoUrl == null
                            ? Center(
                                child: Icon(
                                  Icons.storefront_outlined,
                                  size: 80,
                                  color: toggle2color.withOpacity(0.7),
                                ),
                              )
                            : null,
                      ),

                      // Owner Photo - Overlapping Circle Avatar
                      Positioned(
                        bottom: -45,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          backgroundImage: ownerPhotoUrl != null
                              ? NetworkImage(ownerPhotoUrl!)
                              : null,
                          child: ownerPhotoUrl == null
                              ? Icon(Icons.person,
                                  size: 50, color: toggle2color)
                              : null,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // Shop Name & Hours
                  Text(
                    data['name'],
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Open: ${data['shoptime']}",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 30),

                  // Info Cards
                  infoCard(data['phone'], Icons.phone),
                  infoCard(data['location'], Icons.location_city),
                  infoCard(data['email'], Icons.email),
                  infoCard(data['Address'], Icons.map),

                  const SizedBox(height: 30),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        actionIconButton(
                            context, Icons.feedback_outlined, "Feedback", () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CommonCommentRating()));
                        }),
                        const SizedBox(height: 16),
                        actionIconButton(
                            context, Icons.light_mode_outlined, "Light Mode",
                            () {
                          // Light mode toggle logic here
                        }),
                        const SizedBox(height: 16),
                        actionIconButton(
                            context, Icons.logout_outlined, "Logout", ()async {
                          // Logout logic here
                         await Firebaseothservices().signOut();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Commonlogin()),
                            (route) => false,
                          );
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: toggle2color,
              child: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => Shopeditprfile()));
              },
              tooltip: 'Edit Profile',
            ),
          );
        });
  }
}
