import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/text_edit_crad.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/Customer_Profile.dart';
import 'package:image_picker/image_picker.dart';

class EditCustomerProfile extends StatefulWidget {
  const EditCustomerProfile({super.key});

  @override
  State<EditCustomerProfile> createState() => _EditCustomerProfileState();
}

class _EditCustomerProfileState extends State<EditCustomerProfile> {
  final _edieownername = TextEditingController();
  final _editnumber = TextEditingController();
  final _editshopname = TextEditingController();
  final _edittime = TextEditingController();
  final _editpalce = TextEditingController();
  final _editemail = TextEditingController();
  final _editlocation = TextEditingController();

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
      appBar: AppBar(
          // title: Text("Profile"),
          // leading: Icon(Icons.keyboard_return),
          ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 10,
                child: Container(
                  width: 393,
                  height: 246,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: photocolor,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Stack(children: [
                          //  CircleAvatar(
                          //   radius: 62.5,

                          //   child:
                          //    Image(image:
                          // _image == null
                          //                               ? AssetImage(
                          //       "asset/dummy profile photo.jpg")
                          //                               : FileImage(
                          //       _image!,
                          //     ),fit: BoxFit.cover,),
                          //   // Icon(Icons.person,size: 96,)
                          //  ),
                          Container(
                              width: 125,
                              height: 125,
                              decoration: BoxDecoration(
                                border: Border.all(color: photocolor),
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: _image == null
                                      ? AssetImage(
                                          "asset/dummy profile photo.jpg")
                                      : FileImage(
                                          _image!,
                                        ),
                                ),
                              )),

                          Positioned(
                              right: -10,
                              bottom: -10,
                              child: IconButton(
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
                                                    fontSize: 24,
                                                    fontFamily: "Inria_Sans"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "You can only one post at a time",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: "Inria_Sans"),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    pickimage(
                                                        ImageSource.camera);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.camera_alt),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("image from camera",
                                                          style: const TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Inria_Sans",
                                                              color: bluetext)),
                                                    ],
                                                  )),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    pickimage(
                                                        ImageSource.gallery);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.upload),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Upload from device",
                                                          style: const TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Inria_Sans",
                                                              color: bluetext)),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.camera_enhance,
                                    size: 30,
                                  )))
                        ]),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 151,
                          child: TextFormField(
                            controller: _edieownername,
                            validator: (value) {},
                            decoration: InputDecoration(hintText: "Shop Owner"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextEditCrad(
                cardhight: 60,
                cardwidth: 360,
                controlle: _editnumber,
                text: "Mobile Number",
                validato: (p0) {},
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              TextEditCrad(
                cardhight: 60,
                cardwidth: 360,
                controlle: _editpalce,
                text: "Place",
                validato: (p0) {},
              ),
              SizedBox(
                height: 10,
              ),
              TextEditCrad(
                cardhight: 60,
                cardwidth: 360,
                controlle: _editemail,
                text: "Email",
                validato: (p0) {},
              ),
              SizedBox(
                height: 10,
              ),
              TextEditCrad(
                cardhight: 159,
                cardwidth: 360,
                controlle: _editlocation,
                text: "Location",
                validato: (p0) {},
                maxlen: 5,
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    width: 360,
                    height: 60,
                    decoration: BoxDecoration(
                        color: toggle2color,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Ok",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CustomerProfile()));
                },
                child: Card(
                  elevation: 10,
                  child: Container(
                    width: 360,
                    height: 60,
                    decoration: BoxDecoration(
                        color: butcolor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
