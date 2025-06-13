import 'package:cloud_firestore/cloud_firestore.dart';

class AddOfferModel {
  final String id;              
  final String image;
  final Timestamp startDate;
  final Timestamp endDate;
  final String uid;             
  final bool isActive;         

  AddOfferModel({
    required this.id,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.uid,
    this.isActive = true,
  });

  factory AddOfferModel.fromMap(Map<String, dynamic> map, {required String docId}) {
    return AddOfferModel(
      id: docId,
      image: map['image'] ?? '',
      startDate: map['startDate'] ?? Timestamp.now(),
      endDate: map['endDate'] as Timestamp,
      uid: map['uid'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'startDate': startDate,
      'endDate': endDate,
      'uid': uid,
      'isActive': isActive,
    };
  }
}
