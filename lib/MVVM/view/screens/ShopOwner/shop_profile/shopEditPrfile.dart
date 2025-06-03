import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/text_edit_crad.dart';

class Shopeditprfile extends StatefulWidget {
  const Shopeditprfile({super.key});

  @override
  State<Shopeditprfile> createState() => _ShopeditprfileState();
}

class _ShopeditprfileState extends State<Shopeditprfile> {
  final _edieownername = TextEditingController();
  final _editnumber = TextEditingController();
  final _editshopname = TextEditingController();
  final _edittime = TextEditingController();
  final _editpalce = TextEditingController();
  final _editemail = TextEditingController();
  final _editlocation = TextEditingController();

  String? _imageUrl;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        _edieownername.text = data['name'] ?? '';
        _editnumber.text = data['phone'] ?? '';
        _editshopname.text = data['shopname'] ?? '';
        _edittime.text = data['shoptime'] ?? '';
        _editpalce.text = data['location'] ?? '';
        _editemail.text = data['email'] ?? '';
        _editlocation.text = data['Address'] ?? '';
        setState(() {});
      }
    }
  }

  Future<void> _saveProfile() async {
    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': _edieownername.text.trim(),
      'phone': _editnumber.text.trim(),
      'location': _editpalce.text.trim(),
      'shopname': _editshopname.text.trim(),
      'shoptime': _edittime.text.trim(),
      'email': _editemail.text.trim(),
      'Address': _editlocation.text.trim(),
      'role': 'ShopOwner',
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: toggle2color,
        title: const Text("Edit Shop Profile"),
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _buildProfileCard("Owner", _edieownername),
            const SizedBox(height: 20),
            _buildTextFieldCard("Mobile Number", _editnumber),
            const SizedBox(height: 20),
            _buildShopCard(_editshopname, _edittime),
            const SizedBox(height: 20),
            _buildTextFieldCard("location", _editpalce),
            const SizedBox(height: 20),
            _buildTextFieldCard("Email", _editemail),
            const SizedBox(height: 20),
            _buildTextFieldCard("Address", _editlocation, maxLines: 4),
            const SizedBox(height: 30),
            _buildActionButton("Save Changes", toggle2color, Icons.save, _saveProfile),
            const SizedBox(height: 12),
            _buildActionButton("Cancel", Colors.grey.shade400, Icons.cancel, () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldCard(String label, TextEditingController controller, {int maxLines = 1}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(String label, TextEditingController controller) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: photocolor.withOpacity(0.3),
                  child: const Icon(Icons.person, size: 40, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: toggle2color,
                    child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "$label Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopCard(TextEditingController nameCtrl, TextEditingController timeCtrl) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: photocolor.withOpacity(0.3),
                      child: const Icon(Icons.store, size: 40, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: toggle2color,
                        child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: nameCtrl,
                        decoration: InputDecoration(
                          labelText: "Shop Name",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: timeCtrl,
                        decoration: InputDecoration(
                          labelText: "Shop Time",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}