import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';

class ShopCustomerChat extends StatefulWidget {
  const ShopCustomerChat({super.key});

  @override
  State<ShopCustomerChat> createState() => _ShopCustomerChatState();
}

class _ShopCustomerChatState extends State<ShopCustomerChat> {
  final TextEditingController chatController = TextEditingController();

  void sendMessage() {
    if (chatController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter some messages")),
      );
    } else {
      print("Message Sent: ${chatController.text}");
      chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chatbackground,
      appBar: AppBar(
        backgroundColor: toggle2color,
        leading: IconButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.keyboard_return,
            color: Colors.white,
          ),
          iconSize: 35,
        ),
        title: Row(
          children: [
            CircleAvatar(
                // radius: 25,
                ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Customer Name",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Calling Customer")));
              });
            },
            icon: Icon(
              Icons.phone,
              color: Colors.white,
            ),
            iconSize: 35,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Container()), // Chat messages will go here
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 311,
                      height: 50,
                      child: TextField(
                        controller: chatController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: Icon(Icons.camera_alt),
                          hintText: "Type a message...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(05.0),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: greenbutton,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          // color: toglecolor,
                          onPressed: sendMessage,
                          icon: const Icon(
                            Icons.mic,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: greenbutton,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          // color: toglecolor,
                          onPressed: sendMessage,
                          icon: const Icon(
                            Icons.send,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
