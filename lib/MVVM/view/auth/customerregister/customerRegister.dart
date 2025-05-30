import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/firebaseauthservices.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/customebutton.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/custome/custometextfield.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/view/auth/customerregister/customerdetails.dart';
import 'package:provider/provider.dart';

class Customerregister extends StatefulWidget {
  String role;
  Customerregister({super.key, required this.role});

  @override
  State<Customerregister> createState() => _CustomerregisterState();
}

class _CustomerregisterState extends State<Customerregister> {
  final _Email = TextEditingController();
  final _Password = TextEditingController();
  final _Conferm = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Custometextfield(
                  hinttext: "Email",
                  validate: (p0) {
                    if (_Email.text.isEmpty) {
                      return "Enter Email Please";
                    }
                    return null;
                  },
                  textEditingController: _Email),
              SizedBox(
                height: 10,
              ),
              Custometextfield(
                  hinttext: "Password",
                  validate: (p0) {
                    if (_Password.text.isEmpty) {
                      return "Enter Password Please";
                    }
                    return null;
                  },
                  textEditingController: _Password),
              SizedBox(
                height: 10,
              ),
              Custometextfield(
                  hinttext: "Conferm Password",
                  validate: (p0) {
                    if (_Conferm.text.isEmpty) {
                      return "Enter Confrem Your Password Please";
                    } else if (_Conferm.text != _Password.text) {
                      return "Enter Confrem Your Password And Conferm Password Please";
                    }
                    return null;
                  },
                  textEditingController: _Conferm),
              SizedBox(
                height: 20,
              ),
              Customebutton(
                  textcolor: Colors.white,
                  textsize: 20,
                  textweight: FontWeight.bold,
                  width: 350,
                  hight: 60,
                  onPressed: () async{
                 
                      if (formkey.currentState!.validate()) {
                        final user = await Firebaseothservices().createUser(
                            context,
                            _Email.text.trim(),
                            _Password.text.trim(),
                            widget.role,);
                            if(user != null){
                               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Customerdetails()));
                                 await Firebaseothservices()
                            .dbuser
                            .collection('users')
                            .doc(Firebaseothservices().uid)
                            .update({
                              'isCustomerVerified':false,
                            });
                            }
                      } else if (_Conferm.text != _Password.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 10,
                            backgroundColor: toggle2color,
                            shape: CircleBorder(eccentricity: 0.9),
                            content: Text(
                              "Please Check Your Email And Password",
                              textAlign: TextAlign.center,
                            )));
                      }
                   
                  },
                  text: "Submit",
                  color: WidgetStatePropertyAll(redbutton))
            ],
          ),
        ),
      ),
    );
  }
}
