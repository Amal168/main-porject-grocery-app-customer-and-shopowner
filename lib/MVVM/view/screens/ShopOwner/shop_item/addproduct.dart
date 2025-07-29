import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final _categoryController = TextEditingController();
  final _typeController = TextEditingController();

  List<String> _categories = [];
  List<String> _types = [];

  File? _image;

  @override
  void initState() {
    super.initState();
    _fetchCategoryAndType();
  }

  Future<void> _fetchCategoryAndType() async {
    final snapshot = await FirebaseFirestore.instance.collection('products').get();

    final categorySet = <String>{};
    final typeSet = <String>{};

    for (var doc in snapshot.docs) {
      final category = doc['Category']?.toString();
      final type = doc['type']?.toString();
      if (category != null && category.trim().isNotEmpty) categorySet.add(category);
      if (type != null && type.trim().isNotEmpty) typeSet.add(type);
    }

    setState(() {
      _categories = categorySet.toList();
      _types = typeSet.toList();
    });
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
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("From Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _submitProduct() async {
    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _unitController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _categoryController.text.isEmpty ||
        _typeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final productId = FirebaseFirestore.instance.collection('products').doc().id;

    await FirebaseFirestore.instance.collection('products').doc(productId).set({
      "product_id": productId,
      "user_id": user.uid,
      "product_name": _nameController.text.trim(),
      "product_price": _priceController.text.trim(),
      "unit": _unitController.text.trim(),
      "Category": _categoryController.text.trim(),
      "type": _typeController.text.trim(),
      "stock": int.tryParse(_stockController.text.trim()) ?? 0,
      "created_at": FieldValue.serverTimestamp(),
    });

    _nameController.clear();
    _priceController.clear();
    _unitController.clear();
    _stockController.clear();
    _categoryController.clear();
    _typeController.clear();
    setState(() {
      _image = null;
    });

    Navigator.pop(context);
  }

  Widget _buildAutocompleteField({
    required String label,
    required TextEditingController controller,
    required List<String> options,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) return const Iterable<String>.empty();
        return options.where((option) =>
            option.toLowerCase().contains(textEditingValue.text.toLowerCase()));
      },
      onSelected: (String selection) {
        controller.text = selection;
      },
      fieldViewBuilder: (context, fieldController, focusNode, onFieldSubmitted) {
        fieldController.text = controller.text;
        fieldController.selection = controller.selection;
        fieldController.addListener(() {
          controller.value = fieldController.value;
        });

        return TextFormField(
          controller: fieldController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: "Enter or select $label",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            filled: true,
            fillColor: Colors.white,
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Add New Product"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black12,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _showImagePickerDialog,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: _image != null
                              ? FileImage(_image!)
                              :  AssetImage(
                                  'assets/default image.png'
                                ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                _buildLabel("Product Name"),
                CustomTextField(controller: _nameController, hintText: "Enter product name"),
                const SizedBox(height: 15),
                _buildLabel("Price"),
                CustomTextField(controller: _priceController, hintText: "Enter price", keyboardType: TextInputType.number),
                const SizedBox(height: 15),
                _buildLabel("Unit"),
                CustomTextField(controller: _unitController, hintText: "kg / g / pcs"),
                const SizedBox(height: 15),
                _buildLabel("Category"),
                _buildAutocompleteField(
                  label: 'Category',
                  controller: _categoryController,
                  options: _categories,
                ),
                const SizedBox(height: 15),
                _buildLabel("Type"),
                _buildAutocompleteField(
                  label: 'Type',
                  controller: _typeController,
                  options: _types,
                ),
                const SizedBox(height: 15),
                _buildLabel("Stock"),
                CustomTextField(controller: _stockController, hintText: "Enter stock", keyboardType: TextInputType.number),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitProduct,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text(
                      "Add Product",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
