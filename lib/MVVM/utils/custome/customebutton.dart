import 'package:flutter/material.dart';

class Customebutton extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  double? width;
  double? textsize;
  Color? textcolor;
  double? hight;
  String? textstyl;
  FontWeight? textweight;
  WidgetStateProperty<Color?>? color;
  WidgetStateProperty<BorderSide?>? borderthick;
  WidgetStateProperty<OutlinedBorder?>? shape;
  Customebutton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.textstyl,
    this.borderthick,
    this.hight,
    this.width,
    this.textcolor,
    this.textsize,
    this.textweight,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: width,
      height: hight,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: color, side: borderthick, shape: shape),
          onPressed: onPressed,
          child: Text(
            text!,
            style: TextStyle(
              fontFamily: textstyl,
              fontSize: textsize,
              color: textcolor,
              fontWeight: textweight,
            ),
          )),
    );
  }
}
