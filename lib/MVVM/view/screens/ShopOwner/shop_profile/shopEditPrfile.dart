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
        _editpalce.text = data['place'] ?? '';
        _editemail.text = data['email'] ?? '';
        _editlocation.text = data['location'] ?? '';
        // _imageUrl = data['imageUrl'];
        setState(() {});
      }
    }
  }

  Future<void> _saveProfile() async {
  if (user == null) return;

  await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
    'name': _edieownername.text.trim(),
    'phone': _editnumber.text.trim(),
    'place': _editpalce.text.trim(),
    'shopname': _editshopname.text.trim(),
    'shoptime': _edittime.text.trim(),
    'email': _editemail.text.trim(),
    'location': _editlocation.text.trim(),
    // 'imageUrl': _imageUrl ?? '', // For future image support
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
      backgroundColor: Colors.grey.shade100,
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
            const SizedBox(height: 16),
            TextEditCrad(
              cardhight: 60,
              cardwidth: 360,
              controlle: _editnumber,
              text: "Mobile Number",
              validato: (p0) {},
            ),
            const SizedBox(height: 16),
            _buildShopCard(_editshopname, _edittime),
            const SizedBox(height: 16),
            TextEditCrad(
              cardhight: 60,
              cardwidth: 360,
              controlle: _editpalce,
              text: "Place",
              validato: (p0) {},
            ),
            const SizedBox(height: 16),
            TextEditCrad(
              cardhight: 60,
              cardwidth: 360,
              controlle: _editemail,
              text: "Email",
              validato: (p0) {},
            ),
            const SizedBox(height: 16),
            TextEditCrad(
              cardhight: 159,
              cardwidth: 360,
              controlle: _editlocation,
              text: "Location",
              validato: (p0) {},
              maxlen: 5,
            ),
            const SizedBox(height: 20),
            _buildActionButton("Save", toggle2color, Icons.check, () {
              // Handle save logic
              _saveProfile();
            }),
            const SizedBox(height: 10),
            _buildActionButton("Cancel", butcolor, Icons.close, () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String label, TextEditingController controller) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: photocolor.withOpacity(0.4),
                  child:
                      const Icon(Icons.person, size: 60, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: toggle2color,
                    child: const Icon(Icons.camera_alt,
                        size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: "$label Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopCard(
      TextEditingController nameCtrl, TextEditingController timeCtrl) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: photocolor.withOpacity(0.4),
                  child: const Icon(Icons.store, size: 55, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: toggle2color,
                    child: const Icon(Icons.camera_alt,
                        size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: "Shop Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: timeCtrl,
                    decoration: InputDecoration(
                      labelText: "Shop Time",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String text, Color color, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 360,
      height: 55,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
