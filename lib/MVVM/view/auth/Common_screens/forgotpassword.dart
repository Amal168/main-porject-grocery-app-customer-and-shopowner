
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final passwordforgot = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(Icons.keyboard_return),
          iconSize: 35,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: 350,
                  height: 265,
                  child: Image(
                    image: AssetImage(
                      "asset/360_F_492751838_Ybun2zwpQC8AZv11AwZLdXJk4cUrTt5z.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 101,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Forgot\nPassword ?",
                          style: TextStyle(fontSize: 36),
                        ),
                        Text(
                          "Don’t worry ! it happens.",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 35,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter Your Email Here",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    )),
                Custometextfield(
                    hinttext: "Email",
                    validate: (p0) {},
                    textEditingController: passwordforgot),
                SizedBox(
                  height: 60,
                ),
                Customebutton(
                  borderthick: WidgetStatePropertyAll(BorderSide()),
                  textcolor: Colors.black,
                  textsize: 21,
                  textweight: FontWeight.bold,
                  width: 139,
                  hight: 48,
                  onPressed: () {
                     setState(() {
              Navigator.pop(context);
            });
                  },
                  text: "ok",
                  
                  color: WidgetStatePropertyAll(greenbutton),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
