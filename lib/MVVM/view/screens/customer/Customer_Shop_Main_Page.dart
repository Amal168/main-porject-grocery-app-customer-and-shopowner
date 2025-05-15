
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/slider.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/Customer_Profile.dart';
class CustomerShopMainPage extends StatefulWidget {
  const CustomerShopMainPage({super.key});

  @override
  State<CustomerShopMainPage> createState() => _CustomerShopMainPageState();
}

class _CustomerShopMainPageState extends State<CustomerShopMainPage> {
  final TextEditingController _search = TextEditingController();
  final List<Map<String, dynamic>> customerShopNear = [
    {
      "ShopName": "Devakaran's Shop",
      "ShopPlace": "Dayankave",
      "PhoneNumber": "3254589247"
    },
    {
      "ShopName": "milma",
      "ShopPlace": "Dayankave",
      "PhoneNumber": "1234567890"
    },
    {
      "ShopName": "Athul",
      "ShopPlace": "Mathotezham",
      "PhoneNumber": "3692581407"
    },
    {
      "ShopName": "Almas",
      "ShopPlace": "Mathotezham",
      "PhoneNumber": "1593574862"
    },
    {
      "ShopName": "mrithul's Shop",
      "ShopPlace": "K T thazham",
      "PhoneNumber": "1237890456"
    }
  ];
  final List<Map<String, dynamic>> customerShopOther = [
    {
      "ShopName": "Devakaran's Shop",
      "ShopPlace": "Potamil",
      "PhoneNumber": "3254589247"
    },
    {"ShopName": "milma", "ShopPlace": "Potamil", "PhoneNumber": "1234567890"},
    {
      "ShopName": "Athul",
      "ShopPlace": "Kachilate",
      "PhoneNumber": "3692581407"
    },
    {"ShopName": "Almas", "ShopPlace": "Pala", "PhoneNumber": "1593574862"},
    {
      "ShopName": "mrithul's Shop",
      "ShopPlace": "Kachilate",
      "PhoneNumber": "1237890456"
    },
    {
      "ShopName": "milma",
      "ShopPlace": "PalKambani",
      "PhoneNumber": "1234567890"
    },
    {
      "ShopName": "Athul",
      "ShopPlace": "PalKambani",
      "PhoneNumber": "3692581407"
    },
    {"ShopName": "Almas", "ShopPlace": "Palazhi", "PhoneNumber": "1593574862"},
    {
      "ShopName": "mrithul's Shop",
      "ShopPlace": "Pala",
      "PhoneNumber": "1237890456"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 43.3,
          child: Custometextfield(
            fronticn: const Icon(Icons.search, size: 22),
            sides: 15,
            wid: 327,
            hei: 43.3,
            hinttext: "Search",
            validate: (p0) {},
            textEditingController: _search,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CustomerProfile()));
              },
              child: CircleAvatar(radius: 25)),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: const Sliderpage(),
              ),
              const SizedBox(height: 10),
              const Text(
                "Nearest Shops",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Inria_Sans",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 169,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: customerShopNear.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigate to the corresponding shop page
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: SizedBox(
                          width: 123,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 86,
                                height: 88,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(15),
                                  image: const DecorationImage(
                                    image: AssetImage("asset/571332.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                customerShopNear[index]["ShopName"],
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(customerShopNear[index]["ShopPlace"],
                                  style: TextStyle(fontSize: 14)),
                              Text(customerShopNear[index]["PhoneNumber"],
                                  style: TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Other Shops",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Inria_Sans",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: customerShopOther.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 2,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigate to the corresponding shop page
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                image: AssetImage("asset/571332.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            customerShopOther[index]["ShopName"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            customerShopOther[index]["ShopPlace"],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            customerShopOther[index]["PhoneNumber"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
