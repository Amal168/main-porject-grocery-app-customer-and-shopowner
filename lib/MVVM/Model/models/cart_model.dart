class CartModel {
  String? image;
  String? product_name;
  String? product_price;
  String? product_stcok;
  String? subtotal;
  bool? delivery;
  String? discount;
  String? total;
  String? id;
  CartModel(
      {required this.delivery,
      required this.id,
      required this.discount,
      required this.image,
      required this.product_name,
      required this.product_price,
      required this.product_stcok,
      required this.subtotal,
      required this.total});
  factory CartModel.fromMap(Map<String, dynamic> map, {required String docId}) {
    return CartModel(
      id: docId,
      image: map['image'] ?? '',
      delivery: map['delivery'] ?? '',
      discount: map['discount'] ?? '',
      product_name: map['product_name'] ?? '',
      product_price: map['product_price'] ?? '',
      product_stcok: map['product_stcok'] ?? '',
      subtotal: map['subtotal'] ?? '',
      total: map['total'] ?? '',
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "image":image,
      'delivery': delivery,
      'discount': discount,
      'product_name': product_name,
      'product_price': product_price,
      'product_stcok': product_stcok,
      'subtotal': subtotal,
      'total': total,
    };
  }
}
