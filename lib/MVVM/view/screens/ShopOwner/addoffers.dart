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
  List<File> fiphoto = [];
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 24, fontFamily: "Inria_Sans"),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 346,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _image != null
                          ? FileImage(_image!)
                          : const NetworkImage(
                              "https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=180&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                            ) as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                SizedBox(
                  width: 248,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: const [
                                Text(
                                  "Add your shop ads by:",
                                  style: TextStyle(
                                      fontSize: 24, fontFamily: "Inria_Sans"),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "You can only post one at a time",
                                  style: TextStyle(
                                      fontSize: 17, fontFamily: "Inria_Sans"),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    pickimage(ImageSource.camera);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.camera_alt),
                                      SizedBox(width: 10),
                                      Text("Image from Camera",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Inria_Sans",
                                              color: bluetext)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    pickimage(ImageSource.gallery);
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.upload),
                                      SizedBox(width: 10),
                                      Text("Upload from Device",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Inria_Sans",
                                              color: bluetext)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Add Image",
                      style: TextStyle(fontSize: 19, fontFamily: "Inria_Sans"),
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Time Duration",
                    style: TextStyle(fontSize: 24, fontFamily: "Inria_Sans"),
                  ),
                ),
                const SizedBox(height: 23),
                Card(
                  elevation: 10,
                  child: InkWell(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null && pickedDate != setdate) {
                        setState(() {
                          setdate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      width: 346,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        setdate != null
                            ? "${setdate!.day}-${setdate!.month}-${setdate!.year}"
                            : "Choose Date",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                MaterialButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  color: toggle3color,
                  minWidth: 150,
                  height: 50,
                  onPressed: () {
                    if (_image != null) {
                      setState(() {
                        photo.add(_image!);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Offer image added")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select an image")),
                      );
                    }
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(fontSize: 24, fontFamily: "Inria_Sans"),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 346,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _image != null
                          ? FileImage(_image!)
                          : const NetworkImage(
                              "https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=180&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                            ) as ImageProvider,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
