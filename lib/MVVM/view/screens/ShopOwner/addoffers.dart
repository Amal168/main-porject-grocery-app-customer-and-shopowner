import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:image_picker/image_picker.dart';

class Addoffers extends StatefulWidget {
  const Addoffers({super.key});

  @override
  State<Addoffers> createState() => _AddoffersState();
}

class _AddoffersState extends State<Addoffers> {
  List<File> photo = [];
  DateTime? setdate;
  File? _image;

  Future pickimage(ImageSource source) async {
    final imagefile = await ImagePicker().pickImage(source: source);
    if (imagefile != null) {
      setState(() {
        _image = File(imagefile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Add Offer",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: toggle3color,
        elevation: 6,
        shadowColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Upload Image",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800)),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade400),
                image: DecorationImage(
                  image: _image != null
                      ? FileImage(_image!)
                      : const NetworkImage(
                              "https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=180&h=180")
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label:
                    const Text("Choose Image", style: TextStyle(fontSize: 16)),
                onPressed: () {
                  if (photo.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: const Text("Select Image Source",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text("Camera"),
                                onTap: () {
                                  Navigator.pop(context);
                                  pickimage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text("Gallery"),
                                onTap: () {
                                  Navigator.pop(context);
                                  pickimage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (photo.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                    return    AlertDialog(
                          title: Text("You Can only submit One Add At a Time"),
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: toggle3color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text("Select Duration",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  setState(() {
                    setdate = pickedDate;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Text(
                  setdate != null
                      ? "${setdate!.day}-${setdate!.month}-${setdate!.year}"
                      : "Pick a Date",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: MaterialButton(
                onPressed: () {
                  if (_image != null) {
                    setState(() {
                      photo.add(_image!);
                      _image = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Offer image added")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select an image")),
                    );
                  }
                },
                minWidth: 200,
                height: 50,
                color: toggle3color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 8,
                child: const Text("Submit Offer",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            // Show Uploaded Offers
            if (photo.isNotEmpty) ...[
              const Divider(height: 40, thickness: 1),
              const Text(
                "Uploaded Offers:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: photo.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        photo[index],
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
