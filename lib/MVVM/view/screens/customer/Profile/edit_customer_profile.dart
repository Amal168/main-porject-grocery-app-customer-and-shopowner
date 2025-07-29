import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/Customer_Profile.dart';

class EditCustomerProfile extends StatefulWidget {
  const EditCustomerProfile({super.key});

  @override
  State<EditCustomerProfile> createState() => _EditCustomerProfileState();
}

class _EditCustomerProfileState extends State<EditCustomerProfile> {
  final _edieownername = TextEditingController();
  final _editnumber = TextEditingController();
  final _editpalce = TextEditingController();
  final _editemail = TextEditingController();
  final _editlocation = TextEditingController();

  File? _image;
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
        _editpalce.text = data['location'] ?? '';
        _editemail.text = data['email'] ?? '';
        _editlocation.text = data['Address'] ?? '';
        // _imageUrl = data['imageUrl'];
        setState(() {});
      }
    }
  }

  Future<void> _saveProfile() async {
    if (user == null) return;

    String? downloadUrl = _imageUrl;

    // if (_image != null) {
    //   final storageRef = FirebaseStorage.instance
    //       .ref()
    //       .child('user_images/${user!.uid}.jpg');

    //   await storageRef.putFile(_image!);
    //   downloadUrl = await storageRef.getDownloadURL();
    // }

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': _edieownername.text,
      'phone': _editnumber.text,
      'place': _editpalce.text,
      'email': _editemail.text,
      'location': _editlocation.text,
      // 'imageUrl': downloadUrl ?? '',
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully")),
    );

    Navigator.pop(context);
  }

  Future pickimage(ImageSource source) async {
    final imagefile = await ImagePicker().pickImage(source: source);
    if (imagefile != null) {
      setState(() {
        _image = File(imagefile.path);
      });
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Select Profile Image"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take from camera"),
              onTap: () {
                Navigator.pop(context);
                pickimage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from gallery"),
              onTap: () {
                Navigator.pop(context);
                pickimage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = _image != null
        ? FileImage(_image!)
        : (_imageUrl != null
            ? NetworkImage(_imageUrl!)
            : const AssetImage("assets/dummy profile photo.jpg") as ImageProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: toggle2color,
        centerTitle: true,
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.83,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: profileImage,
                          backgroundColor: Colors.grey[200],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _showImagePickerDialog,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: toggle2color,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.camera_alt, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(_edieownername, "Customer Name"),
                  const SizedBox(height: 10),
                  _buildTextField(_editnumber, "Mobile Number", keyboardType: TextInputType.phone),
                  const SizedBox(height: 10),
                  _buildTextField(_editpalce, "Place"),
                  const SizedBox(height: 10),
                  _buildTextField(_editemail, "Email", keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 10),
                  _buildTextField(_editlocation, "Location", maxLines: 5,minLines: 5),
                  const SizedBox(height: 30),
                ],
              ),
              Row(
                children: [
                  _buildButton("Save", toggle2color, _saveProfile),
                  const SizedBox(width: 10),
                  _buildButton("Cancel", butcolor, () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const CustomerProfile()),
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {TextInputType keyboardType = TextInputType.text, int minLines = 1, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
