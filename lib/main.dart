import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/Commonlogin.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/SplashScreen.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/Common_screens/forgotpassword.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/customerregister/customerdetails.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/shopownwe/shopownerdetail.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/Common_Screen/CommonCommentRating.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderReceavedList.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/orderSendList.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_Order/shop_customer_profile.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_bottum_bar.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_item/addproduct.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/ShopOwner/shop_profile/shopprofile.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Customer_Shop_Main_Page.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Customer_shop.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/screens/customer/Profile/Customer_Profile.dart';
import 'package:grocery_customer_and_shopowner2/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splashscreen()
    );
  }
}
