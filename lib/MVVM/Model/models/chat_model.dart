import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String uid;
  final String receiverId;
  final String senderId;
  final String senderName;
  final String senderPhone;
  final Timestamp createdAt;

  ChatModel({
    required this.message,
    required this.uid,
    required this.receiverId,
    required this.senderId,
    required this.senderName,
    required this.senderPhone,
    required this.createdAt,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: map['message'] ?? '',
      uid: map['uid'] ?? '',
      receiverId: map['receiverId'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      senderPhone: map['senderPhone'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'uid': uid,
      'receiverId': receiverId,
      'senderId': senderId,
      'senderName': senderName,
      'senderPhone': senderPhone,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
