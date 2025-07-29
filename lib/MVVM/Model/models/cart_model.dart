import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String? image;
  String? product_name;
  String? product_price;
  String? product_stock;
  String? subtotal;
  bool? delivery;
  String? discount;
  String? total;
  String? id;
  Timestamp? addat;
  String? cartuid;
  CartModel(
      {required this.delivery,
      required this.id,
      required this.discount,
      required this.image,
      required this.product_name,
      required this.product_price,
      required this.product_stock,
      required this.subtotal,
      required this.total,
      required this.cartuid,
      required this.addat});
  factory CartModel.fromMap(Map<String, dynamic> map, {required String docId}) {
    return CartModel(
      id: docId,
      image: map['image'] ?? '',
      delivery: map['delivery'] ?? '',
      discount: map['discount'] ?? '',
      product_name: map['product_name'] ?? '',
      product_price: map['product_price'] ?? '',
      product_stock: map['product_stock'] ?? '',
      subtotal: map['subtotal'] ?? '',
      total: map['total'] ?? '',
      addat: map['addat'] ?? '',
      cartuid: map['cartuid'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "image": image,
      'delivery': delivery,
      'discount': discount,
      'product_name': product_name,
      'product_price': product_price,
      'product_stock': product_stock,
      'subtotal': subtotal,
      'total': total,
      'addat': addat,
      'cartuid': cartuid,
    };
  }
}
