import 'package:cloud_firestore/cloud_firestore.dart';

class AllUserModel {
  String? email;
  String? uid;
  String? role;
  String? name;
  String? shopname;
  String? shoptime;
  String? phone;
  String? place;
  String? location;
  FieldValue? createAt;

  AllUserModel({
    this.shopname,
    this.shoptime,
    this.uid,
    this.email,
    this.role,
    this.name,
    this.phone,
    this.place,
    this.location,
    this.createAt,
  });

  factory AllUserModel.fromMap(Map<String, dynamic> map) {
    return AllUserModel(
      email: map['email'],
      uid: map['uid'],
      role: map['role'],
      name: map['name'],
      shopname: map['shopname'],
      shoptime: map['shoptime'],
      phone: map['phone'],
      place: map['place'],
      location: map['location'],
      createAt: map['createAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'shopname': shopname,
      'shoptime': shoptime,
      'role': role,
      'name': name,
      'phone': phone,
      'place': place,
      'location': location,
      'createAt': createAt,
    };
  }
}
