
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
  final _Name = TextEditingController();
  final _price = TextEditingController();
  final _peace = TextEditingController();
  final _stack = TextEditingController();
  String _dropdown1 = "Rice";
  String _dropdown2 = "Red";
  String radiogroup = " ";

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                width: 133,
                height: 133,
                decoration: BoxDecoration(
                  image: DecorationImage(image: _image != null
                          ? FileImage(_image!)
                          : const NetworkImage(
                              "https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=180&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                            ) as ImageProvider,fit: BoxFit.fill),
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30)),
              ),
              Positioned(
                  right: -1,
                  top: 83,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(30)),
                    child: IconButton(
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(30),
                            shadowColor:
                                WidgetStatePropertyAll(Colors.black26)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Take Products Photo"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                           Navigator.pop(context);
                                    pickimage(ImageSource.camera);
                                        },
                                        child: Text("From Camera")),
                                    TextButton(
                                        onPressed: () {
                                           Navigator.pop(context);
                                    pickimage(ImageSource.gallery);
                                        },
                                        child: Text("From Device"))
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.camera_enhance)),
                  ))
            ]),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Name"),
                  Container(
                    height: 49,
                    child: Custometextfield(
                        sides: 15,
                        hinttext: "Product Name",
                        validate: (p0) {},
                        textEditingController: _Name),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Product Price"),
                  Container(
                    height: 49,
                    child: Custometextfield(
                        sides: 15,
                        hinttext: "Price",
                        validate: (p0) {},
                        textEditingController: _price),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Peace/kg/g"),
                  Container(
                    height: 49,
                    child: Custometextfield(
                        sides: 15,
                        hinttext: "Peace/kg/g",
                        validate: (p0) {},
                        textEditingController: _peace),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Catogary"),
                  Container(
                    width: double.infinity,
                    height: 49,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<String>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(20),
                        // focusColor: Colors.white,
                        // dropdownColor: Colors.white,
                        // iconEnabledColor: Colors.white,
                        // iconDisabledColor: Colors.white,
                        value: _dropdown1,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: const [
                          DropdownMenuItem<String>(
                              value: "Rice", child: Text("     Rice")),
                          DropdownMenuItem<String>(
                              value: "Snacks", child: Text("     Snacks")),
                          DropdownMenuItem<String>(
                              value: "toothpast",
                              child: Text("     toothpast")),
                          DropdownMenuItem<String>(
                              value: "Coockoil", child: Text("     Coockoil")),
                          DropdownMenuItem<String>(
                              value: "Soap", child: Text("     Soap")),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdown1 = newValue!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Type"),
                  Container(
                    width: double.infinity,
                    height: 49,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<String>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(20),
                        // focusColor: Colors.amber,
                        // dropdownColor: Colors.white,
                        // iconEnabledColor: Colors.red,
                        // iconDisabledColor: Colors.orange,
                        value: _dropdown2,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: const [
                          DropdownMenuItem<String>(
                              value: "Red",
                              child: Text(
                                "     Red",
                                selectionColor: Colors.red,
                              )),
                          DropdownMenuItem<String>(
                              value: "Green",
                              child: Text(
                                "     Green",
                                selectionColor: Colors.green,
                              )),
                          DropdownMenuItem<String>(
                              value: "Blue", child: Text("     Blue"))
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdown2 = newValue!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Stock"),
                  Container(
                    height: 49,
                    child: Custometextfield(
                        sides: 15,
                        hinttext: "Stock",
                        validate: (p0) {},
                        textEditingController: _stack),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  
                ],
              ),
            ),
            Customebutton(
                hight: 50,
                width: 150,
                textcolor: Colors.white,
                textsize: 18,
                onPressed: () {},
                text: "Add Product",
                color: WidgetStatePropertyAll(toggle2color))
          ],
        ),
      ),
    );
  }
}
