import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
class CustomerAllTab extends StatefulWidget {
  CustomerAllTab({super.key});

  @override
  State<CustomerAllTab> createState() => _CustomerAllTabState();
}

class _CustomerAllTabState extends State<CustomerAllTab> {
  String radiobuttion = " ";
  int selectIndex = 0;
   Color lowcolor = redbutton;
  Color highcolor = toglecolor;
  int count = 6;
   bool buttonindex=true;
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
                            // child: Image.asset("asset/images (1).jpg",fit: BoxFit.cover,),
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
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    buttonindex == 0
                                        ? Colors.white
                                        : toggle2color)),
                            onPressed: () {},
                            child: Text(
                              "Selet",
                              style: TextStyle(
                                  color: buttonindex == 0
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          )
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
