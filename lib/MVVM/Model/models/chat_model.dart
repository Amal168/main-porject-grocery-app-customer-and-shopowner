import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String receiverId;
  final String senderId;
  final String senderName;
  final String senderPhone;
  final Timestamp createdAt;

  ChatModel({
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.senderName,
    required this.senderPhone,
    required this.createdAt,
  });



  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'receiverId': receiverId,
      'senderId': senderId,
      'senderName': senderName,
      'senderPhone': senderPhone,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
