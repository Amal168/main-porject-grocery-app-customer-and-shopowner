import 'package:flutter/material.dart';

class TextDisplayCards extends StatelessWidget {
  String text;
  double cardwidth;
  double cardhight;
  TextDisplayCards({super.key, required this.text,required this.cardhight,required this.cardwidth});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: cardwidth,
        height: cardhight,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}
