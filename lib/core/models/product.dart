import 'package:flutter/cupertino.dart';

class Product {
  final String prodId;
  final String prodName;
  final String prodImage;
  final double prodPrice;
  final double prodSellPrice;
  int quantity;

  Product({
    @required this.prodId,
    @required this.prodName,
    @required this.prodImage,
    @required this.prodPrice,
    @required this.prodSellPrice,
    this.quantity = 1,
  });

  static Map<String, dynamic> toMap(Product product) {
    var map = Map<String, dynamic>();
    map['prodId'] = product.prodId;
    map['prodName'] = product.prodName;
    map['prodImage'] = product.prodImage;
    map['prodPrice'] = product.prodPrice;
    map['prodSell'] = product.prodSellPrice;

    return map;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      prodId: map['prodId'].toString(),
      prodName: map['prodName'] as String,
      prodImage: map['prodImage'] as String,
      prodPrice: double.parse('${map['prodPrice']}'),
      prodSellPrice: double.parse('${map['prodSell']}'),
    );
  }
}
