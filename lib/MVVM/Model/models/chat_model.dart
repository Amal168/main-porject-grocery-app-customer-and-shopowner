import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? massage;
  String? uid;
  String? reciverid;
  String? senderid;
  String? sendername;
  String? senderphone;
  FieldValue? createAt;

  ChatModel({
    this.createAt,
    this.massage,
    this.reciverid,
    this.senderid,
    this.sendername,
    this.senderphone,
    this.uid
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      createAt: map['createAt'],
      massage: map['massage'],
      reciverid: map['reciverid'],
      senderid: map['senderid'],
      sendername: map['sendername'],
      senderphone: map['senderphone'],
      uid: map['uid']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createAt':createAt,
      'massage':massage,
      'reciverid':reciverid,
      'senderid':senderid,
      'sendername':sendername,
      'senderphone':senderphone,
      'uid':uid
    };
  }
}
