import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class AllTab extends StatefulWidget {
  AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  final stocknumber = TextEditingController();
  String radiobuttion = " ";
  int selectIndex = 0;
  Color lowcolor = redbutton;
  Color highcolor = toglecolor;
  int count = 6;
  bool buttonindex = true;

  void buttoncolor(index) {
    setState(() {
      buttonindex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 3,
                  mainAxisExtent: 370),
              itemBuilder: (context, index) {
                switch (selectIndex) {
                  case 0:
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 118,
                            height: 121,
                            child: Image.asset("assets/images.jpg",fit: BoxFit.cover,),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Product Name",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Only ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: count < 4 ? lowcolor : highcolor)),
                              Text("${count} ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: count < 4 ? lowcolor : highcolor)),
                              Text("Left",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: count < 4 ? lowcolor : highcolor)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("100g 20Rs", style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      // side:
                                      //     WidgetStatePropertyAll(BorderSide()),
                                      backgroundColor:
                                          WidgetStatePropertyAll(button1)),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: TextFormField(
                                            controller: stocknumber,
                                            validator: (value) {
                                              if (stocknumber.text.isEmpty) {
                                                return "Enter the stocks";
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                labelText: "Stock Number"),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                },
                                                child: Text("Cancel")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  
                                                },
                                                child: Text("ok"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Restock",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      // side:
                                      //     WidgetStatePropertyAll(BorderSide()),
                                      backgroundColor:
                                          WidgetStatePropertyAll(button2)),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Are You Sure",textAlign: TextAlign.center,),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                },
                                                child: Text("Cancel")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("ok"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    );
                  case 1:
                    return Center(
                      child: Text("No data"),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
