import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:image_picker/image_picker.dart';

class Addoffers extends StatefulWidget {
  const Addoffers({super.key});

  @override
  State<Addoffers> createState() => _AddoffersState();
}

class _AddoffersState extends State<Addoffers> {
  DateTime? setdate;
  File? _image;
  Future pickimage(ImageSource source) async {
    final imagefile = await ImagePicker().pickImage(source: source);
    setState(() {
      if (imagefile != null) _image = File(imagefile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Add",
                      style: const TextStyle(
                          fontSize: 24, fontFamily: "Inria_Sans"))),
              Container(
                width: 346,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: _image == null
                          ? NetworkImage(
                              "https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=180&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7")
                          : FileImage(
                              _image!,
                            ),
                    )),
              ),
              SizedBox(
                height: 23,
              ),
              Container(
                width: 248,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Column(
                              children: [
                                const Text(
                                  "Add your shop adds \n by:",
                                  style: TextStyle(
                                      fontSize: 24, fontFamily: "Inria_Sans"),
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  "You can only one post at a time",
                                  style: TextStyle(
                                      fontSize: 17, fontFamily: "Inria_Sans"),
                                ),
                                SizedBox(height: 20,),

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
                                      children: [
                                        Icon(Icons.camera_alt),
                                        SizedBox(width: 10,),
                                        Text("image from camera", style: const TextStyle(
                                          fontSize: 24, fontFamily: "Inria_Sans",color: bluetext)),
                                      ],
                                    )),
                                SizedBox(height: 20,),

                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      pickimage(ImageSource.gallery);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.upload),
                                        SizedBox(width: 10,),
                                        Text("Upload from device", style: const TextStyle(
                                          fontSize: 24, fontFamily: "Inria_Sans",color: bluetext)),
                                      ],
                                    ))
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text("Add Image",
                        style:
                            TextStyle(fontSize: 19, fontFamily: "Inria_Sans"))),
              ),
              SizedBox(
                height: 23,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Time Duration",
                      style:
                          TextStyle(fontSize: 24, fontFamily: "Inria_Sans"))),
              SizedBox(
                height: 23,
              ),
              Card(
                elevation: 10,
                child: Container(
                  width: 346,
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          currentDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2030));
                      if (pickedDate != null && pickedDate != setdate) {
                        setState(() {
                          setdate = pickedDate;
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                          setdate != null
                              ? "${setdate!.day}-${setdate!.month}-${setdate!.year}"
                              : "Chossen Date",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              MaterialButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: toggle3color,
                minWidth: 150,
                height: 50,
                onPressed: () {},
                child: Text(
                  "Send",
                  style: TextStyle(fontSize: 24, fontFamily: "Inria_Sans"),
                ),
              ),
              SizedBox(
                height: 41,
              ),
              Container(
                width: 346,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage("assetName"))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
