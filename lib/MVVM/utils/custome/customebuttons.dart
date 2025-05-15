import 'package:flutter/material.dart';

class Customebuttons extends StatefulWidget {
 final VoidCallback onpress;
  final String image;
  EdgeInsetsGeometry? padding;

   Customebuttons({super.key, 
  required this.onpress, 
  required this.image, 
   
  required this.padding});

  @override
  State<Customebuttons> createState() => _CustomebuttonsState();
}

class _CustomebuttonsState extends State<Customebuttons> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onpress, 
      icon: Image.asset(widget.image),
      padding: widget.padding,);
  }
}
