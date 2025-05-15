import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/Commonlogin.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTo();
  }

  void initTo() async {
    await Future.delayed(Duration(seconds: 2), () {
      Get.off(Commonlogin(), transition: Transition.leftToRight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset("asset/Screenshot 2025-03-26 131955.png",fit: BoxFit.cover,)
        ],),
      ),
    );
  }
}
