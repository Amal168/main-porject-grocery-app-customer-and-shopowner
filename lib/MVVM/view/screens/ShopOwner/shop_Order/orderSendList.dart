
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/Shop_Customer_Chat.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/shop_customer_profile.dart';
class Ordersendlist extends StatefulWidget {
  const Ordersendlist({super.key});

  @override
  State<Ordersendlist> createState() => _OrderreceavedlistState();
}

class _OrderreceavedlistState extends State<Ordersendlist> {
  List<String> selectedRadioValues = List.generate(3, (index) => '');
  String radiobutton = '';
  final TextEditingController _subtotal = TextEditingController();
  final TextEditingController _deliveryFee = TextEditingController();
  final TextEditingController _discount = TextEditingController();

  @override
  void initState() {
    super.initState();
    _subtotal.addListener(_updateTotal);
    _deliveryFee.addListener(_updateTotal);
    _discount.addListener(_updateTotal);
  }

  @override
  void dispose() {
    _subtotal.removeListener(_updateTotal);
    _deliveryFee.removeListener(_updateTotal);
    _discount.removeListener(_updateTotal);

    _subtotal.dispose();
    _deliveryFee.dispose();
    _discount.dispose();
    super.dispose();
  }

  void _updateTotal() {
    setState(() {});
  }

  double fintottal() {
    double subtotal = double.tryParse(_subtotal.text) ?? 0.0;
    double deliveryFee = double.tryParse(_deliveryFee.text) ?? 0.0;
    double discount = double.tryParse(_discount.text) ?? 0.0;

    return subtotal + deliveryFee - discount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.keyboard_return)),
        title: const Text(
          "List",
          style: TextStyle(
              fontSize: 20,
              fontFamily: "Inknut_Antiqua",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ShopCustomerChat())),
              icon: Icon(Icons.chat)),
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ShopCustomerProfile())),
              icon: Icon(Icons.person)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images.jpg",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Name",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text("1 Piece",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text("20Rs",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: "1",
                            groupValue: selectedRadioValues[index],
                            onChanged: (value) {
                              setState(() {
                                selectedRadioValues[index] = value!;
                              });
                            },
                          ),
                          Text("Check"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "2",
                            groupValue: selectedRadioValues[index],
                            onChanged: (value) {
                              setState(() {
                                selectedRadioValues[index] = value!;
                              });
                            },
                          ),
                          Text("Uncheck"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(),
          itemCount: 3,
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              _buildInputRow("Subtotal", _subtotal, "40.00Rs"),
              SizedBox(height: 10),
              _buildInputRow("Delivery Fee", _deliveryFee,
                  radiobutton == "1" ? "2.00Rs" : "0.00Rs"),
              SizedBox(height: 10),
              _buildInputRow("Discount", _discount, "0.00Rs"),
              SizedBox(height: 10),
              Row(
                children: [
                  Radio<String>(
                    value: '1',
                    groupValue: radiobutton,
                    onChanged: (value) {
                      setState(() {
                        radiobutton = value!;
                        _deliveryFee.text = "2.00";
                      });
                    },
                  ),
                  Text("Delivery"),
                  Radio<String>(
                    value: '2',
                    groupValue: radiobutton,
                    onChanged: (value) {
                      setState(() {
                        radiobutton = value!;
                        _deliveryFee.text = "0.00";
                      });
                    },
                  ),
                  Text("Pickup"),
                ],
              ),
              SizedBox(height: 10),
              MaterialButton(
                elevation: 5,
                minWidth: double.infinity,
                height: 40,
                color: greenbutton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "A message will be sent to the customer\nAbout the order being completed",
                      textAlign: TextAlign.center,
                    ),
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const  Text(
                      "Total:",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Inknut_Antiqua",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹${fintottal().toStringAsFixed(2)}",
                      style:const TextStyle(
                          fontSize: 15,
                          fontFamily: "Inria_Sans",
                          fontWeight: FontWeight.bold),
                    ),
                  const  Row(
                      children: [
                        Text(
                          "Send",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Inknut_Antiqua",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.send)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputRow(
      String label, TextEditingController controller, String hintText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:const TextStyle(
              fontSize: 15,
              fontFamily: "Inknut_Antiqua",
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 100,
          height: 32,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        )
      ],
    );
  }
}
