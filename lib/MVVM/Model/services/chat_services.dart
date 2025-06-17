import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Send a message
  Future<void> sendMessage(String receiverId, String messageText) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // Create unique chat room ID by sorting both UIDs
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // Store message in Firestore
    await _firestore.collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': messageText,
      'createdAt': timestamp,
    });
  }

  // Get messages stream
  Stream<QuerySnapshot> getmessage(String receiverId, String senderId) {
    List<String> ids = [receiverId, senderId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots();
  }
}
