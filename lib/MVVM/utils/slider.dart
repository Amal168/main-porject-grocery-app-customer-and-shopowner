import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Sliderpage extends StatefulWidget {
  const Sliderpage({super.key});

  @override
  State<Sliderpage> createState() => _SliderpageState();
}

class _SliderpageState extends State<Sliderpage> {
  int currentcount = 0;
  final List sliderlist = [
    'asset/add1.png',
    'asset/add2.png',
    'asset/add3.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                  items: sliderlist
                      .map((e) => Card(
                        elevation: 10,
                        child: Container(
                          width: 393,
                              color: Colors.white,
                              child: Center(
                                child: Image.asset(e,fit: BoxFit.cover,),
                              ),
                            ),
                      ))
                      .toList(),
                  options: CarouselOptions(
                    
                    height: 176,
                    initialPage: 0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    // enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentcount = index;
                      });
                    },
                    
                  )
                  
                  ),
                  buildscrolcarouls()
            ],
          ),
              
          // carouls sliderdots
          
          ),
          
    );
    
  }

  buildscrolcarouls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < sliderlist.length; i++)
          Container(
            height: i == currentcount ? 7 : 5,
            width: i == currentcount ? 7 : 5,
            margin: EdgeInsets.all(5),
            decoration:
                BoxDecoration(color:i==currentcount? Colors.black :  Colors.grey, shape: BoxShape.circle),
          )
      ],
    );
  }
}
