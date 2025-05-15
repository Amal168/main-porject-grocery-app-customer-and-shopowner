import 'package:flutter/material.dart';

class TextEditCrad extends StatelessWidget {
  TextEditingController controlle;
  String? Function(String?)? validato;
  String text;
  double cardwidth;
  double cardhight;
  int? maxlen;
  TextEditCrad(
      {super.key,
      required this.cardhight,
      required this.cardwidth,
      required this.controlle,
      required this.text,
      required this.validato,
      this.maxlen
      });

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
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                maxLines: maxlen,
                controller: controlle,
                validator: validato,
                decoration: InputDecoration(
                  hintText: text,
                ),
              )),
        ));
  }
}
