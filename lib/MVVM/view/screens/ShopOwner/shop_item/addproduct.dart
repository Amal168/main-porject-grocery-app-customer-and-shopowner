import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
import 'package:image_picker/image_picker.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _unitController = TextEditingController();
  final _stockController = TextEditingController();
  String _category = "Rice";
  String _type = "Red";
  File? _image;

  Future pickImage(ImageSource source) async {
    final imageFile = await ImagePicker().pickImage(source: source);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Choose Product Photo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("From Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("From Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        title: const Text(
          "Add New Product",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black12,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _showImagePickerDialog,
                  child: Stack(
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image!)
                                : const NetworkImage(
                                        "https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa")
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                _buildLabel("Product Name"),
                Custometextfield(
                  sides: 15,
                  hinttext: "Enter product name",
                  textEditingController: _nameController,
                  validate: (value) {},
                ),
                const SizedBox(height: 15),
                _buildLabel("Price"),
                Custometextfield(
                  sides: 15,
                  hinttext: "Enter price",
                  textEditingController: _priceController,
                  validate: (value) {},
                ),
                const SizedBox(height: 15),
                _buildLabel("Unit"),
                Custometextfield(
                  sides: 15,
                  hinttext: "kg / g / pcs",
                  textEditingController: _unitController,
                  validate: (value) {},
                ),
                const SizedBox(height: 15),
                _buildLabel("Category"),
                _buildDropdown(_category, ["Rice", "Snacks", "Toothpaste", "Cooking Oil", "Soap"], (val) {
                  setState(() => _category = val!);
                }),
                const SizedBox(height: 15),
                _buildLabel("Type"),
                _buildDropdown(_type, ["Red", "Green", "Blue"], (val) {
                  setState(() => _type = val!);
                }),
                const SizedBox(height: 15),
                _buildLabel("Stock"),
                Custometextfield(
                  sides: 15,
                  hinttext: "Enter stock quantity",
                  textEditingController: _stockController,
                  validate: (value) {},
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Add your logic
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 5,
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text(
                    "Add Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(15),
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text("  $item"),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
