import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/Model/services/chat_services.dart';
import 'package:grocery_customer_and_shopowner2/MVVM/utils/color.dart';
import 'package:intl/intl.dart';

class ShopCustomerChat extends StatefulWidget {
  final String senderid;
  final String reciveid;

  ShopCustomerChat({
    super.key,
    required this.reciveid,
    required this.senderid,
  });

  @override
  State<ShopCustomerChat> createState() => _ShopCustomerChatState();
}

class _ShopCustomerChatState extends State<ShopCustomerChat> {
  final TextEditingController chatController = TextEditingController();
  final ChatServices _chatServices = ChatServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String sendername = '';

  @override
  void initState() {
    super.initState();
    getReceiverName();
  }

  Future<void> getReceiverName() async {
    final doc = await FirebaseFirestore.instance
        .collection('users') // Change if using a different collection
        .doc(widget.senderid)
        .get();

    if (doc.exists) {
      setState(() {
        sendername = doc['name'] ?? 'Unknown';
      });
    }
  }

  void sendMessage() async {
    if (chatController.text.trim().isEmpty) return;
    await _chatServices.sendMessage(widget.reciveid, chatController.text.trim());
    chatController.clear();
  }

  void deleteMessage(String docId) async {
    List<String> ids = [widget.reciveid, _firebaseAuth.currentUser!.uid];
    ids.sort();
    String chatRoomId = ids.join("_");

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(docId)
        .delete();
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  bool isCurrentUser = data['senderId'] == _firebaseAuth.currentUser!.uid;
  Alignment alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
  Color bubbleColor = isCurrentUser ? toggle2color : Colors.grey.shade300;
  Color textColor = isCurrentUser ? Colors.white : Colors.black87;

  // Parse the timestamp
  Timestamp timestamp = data['createdAt'] ?? Timestamp.now();
  DateTime dateTime = timestamp.toDate();
  String formattedTime = DateFormat('hh:mm a').format(dateTime); 

  return Align(
    alignment: alignment,
    child: Dismissible(
      key: Key(document.id),
      direction: isCurrentUser ? DismissDirection.endToStart : DismissDirection.none,
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Delete Message"),
            content: const Text("Are you sure you want to delete this message?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Delete")),
            ],
          ),
        );
      },
      onDismissed: (_) => deleteMessage(document.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15)
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formattedTime,
              style: TextStyle(color: textColor, fontSize: 10),
            ),
            const SizedBox(height: 4),
            Text(
              data['message'] ?? '',
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatServices.getmessage(widget.reciveid, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          reverse: false,
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chatbackground,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: toggle2color,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/dummy profile photo.jpg"),
            ),
            const SizedBox(width: 12),
            Text(
              sendername.isNotEmpty ? sendername : "Loading...",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Calling Customer")),
              );
            },
            icon: const Icon(Icons.phone, color: Colors.white),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: chatController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message...",
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          onPressed: () {},
                          color: Colors.grey[700],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _roundedIconButton(
                      icon: Icons.mic,
                      onPressed: sendMessage,
                      color: greenbutton,
                    ),
                    const SizedBox(height: 8),
                    _roundedIconButton(
                      icon: Icons.send,
                      onPressed: sendMessage,
                      color: toggle2color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundedIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
