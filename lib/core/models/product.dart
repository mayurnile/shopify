class Product {
  final String? prodId;
  final String? prodName;
  final String? prodImage;
  final double? prodPrice;
  final double? prodSellPrice;
  int? quantity;

  Product({
    required this.prodId,
    required this.prodName,
    required this.prodImage,
    required this.prodPrice,
    required this.prodSellPrice,
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

  factory Product.fromMap(Map<String, dynamic>? map) {
    if (map != null)
      return Product(
        prodId: map['prodId'] != null ? map['prodId'].toString() : '123',
        prodName: map['prodName'] != null ? map['prodName'].toString() : 'Name',
        prodImage: map['prodImage'] != null ? map['prodImage'].toString() : '',
        prodPrice: map['prodPrice'] != null
            ? double.parse('${map['prodPrice']}')
            : 0.0,
        prodSellPrice:
            map['prodSell'] != null ? double.parse('${map['prodSell']}') : 0.0,
      );

    return Product(
        prodId: '',
        prodName: '',
        prodImage: '',
        prodPrice: 0.0,
        prodSellPrice: 0.0);
  }
}
