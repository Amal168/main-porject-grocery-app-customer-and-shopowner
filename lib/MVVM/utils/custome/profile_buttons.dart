import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class ProfileButtons extends StatelessWidget {
  String text;
  Icon iconph;
  double? hieght;
  double? width;
  Function() ontap;
  ProfileButtons(
      {super.key,
      required this.iconph,
      required this.text,
      required this.ontap,
      this.hieght,
      this.width,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        elevation: 10,
        child: Container(
            width: width ?? 270,
            height: hieght ?? 60,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: photocolor),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconph,
                SizedBox(
                  width: 30,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                )
              ],
            )),
      ),
    );
  }
}
