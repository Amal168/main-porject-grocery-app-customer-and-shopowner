import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/Commonlogin.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/CommonCommentRating.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/edit_customer_profile.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("My Profile",
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
                                    data['name'],
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
                      children:  [
                        InfoTile(label: "Mobile Number", value: data['phone']),
                        Divider(),
                        InfoTile(label: "Place", value: data['place']),
                        Divider(),
                        InfoTile(label: "Email", value: data['email']),
                        Divider(),
                        InfoTile(
                            label: "Location", value: data['location']),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons
                  ButtonTile(
                    icon: Icons.feedback_outlined,
                    label: "Feedback",
                    color: toggle2color,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CommonCommentRating()));
                    },
                  ),
                  ButtonTile(
                    icon: Icons.light_mode,
                    label: "Light Mode",
                    color: Colors.orangeAccent,
                    onTap: () {},
                  ),
                  ButtonTile(
                    icon: Icons.logout,
                    label: "Logout",
                    color: Colors.redAccent,
                    onTap: () {
                      // Firebaseothservices().signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Commonlogin()));
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

// Info row widget
class InfoTile extends StatelessWidget {
  final String label;
  final String value;
  const InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(value, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}

// Button row widget
class ButtonTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  const ButtonTile(
      {required this.icon,
      required this.label,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 12),
              Text(
                label,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
