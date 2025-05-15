
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
                          CircleAvatar(
                            radius: 62.5,
                            backgroundColor: photocolor,
                            child: Icon(
                              Icons.person,
                              size: 94,
                            ),
                          ),
                          Positioned(
                              right: -10,
                              bottom: -10,
                              child: IconButton(
                                  onPressed: () {},
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
              Card(
                color: Colors.white,
                elevation: 10,
                child: Container(
                  width: 360,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Stack(children: [
                              CircleAvatar(
                                radius: 62.5,
                                backgroundColor: photocolor,
                                child: Icon(
                                  Icons.person,
                                  size: 94,
                                ),
                              ),
                              Positioned(
                                  right: -10,
                                  bottom: -10,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.camera_enhance,
                                        size: 30,
                                      )))
                            ]),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 151,
                                  child: TextFormField(
                                    controller: _editshopname,
                                    validator: (value) {},
                                    decoration:
                                        InputDecoration(hintText: "Shop Name"),
                                  ),
                                ),
                                SizedBox(
                                  width: 151,
                                  child: TextFormField(
                                    controller: _edittime,
                                    validator: (value) {},
                                    decoration:
                                        InputDecoration(hintText: "Shop Time"),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
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
                onTap: () {},
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
