import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

import '../core/core.dart';
import '../core/utils/utils.dart';

class ProductsProvider extends GetxController {
  late List<Product> _productsList;
  late List<Product> _cartList;
  late ProductsState _state;

  @override
  void onInit() async {
    super.onInit();

    //initialize variables
    _productsList = [];
    _cartList = [];
    _state = ProductsState.LOADING;

    //getting list of products from api and storing locally
    await fetchAndStoreProductsList();
  }

  get products => _productsList;
  get cartProducts => _cartList;
  get productsState => _state;

  Future<void> fetchAndStoreProductsList() async {
    _state = ProductsState.LOADING;

    DatabaseHelper _databaseHelper = DatabaseHelper();
    final Future<Database> dbFuture = _databaseHelper.initializeDatabase();

    //fetch latest products list if online
    if (await NetworkInfo.isConnected) {
      var url = Uri.parse('https://jsonkeeper.com/b/YIDG');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedJSON = json.decode(response.body);
        List<dynamic> parsedProducts = parsedJSON['data']['products'];

        if (parsedProducts.length != 0) {
          //storing fetched list into database
          dbFuture.then((database) async {
            _databaseHelper.deleteAllProducts();

            parsedProducts.forEach((product) {
              Product newProduct = Product.fromMap(product);
              _databaseHelper.insertProduct(newProduct);
            });

            //fetch list from database
            _productsList = [];
            List<Product> _products = await _databaseHelper.getProductsList();
            _productsList = _products;
          });
        } else {
          _state = ProductsState.NO_PRODUCTS;
        }
      }
    }

    //fetch list from database if list is empty
    if (_productsList.length == 0) {
      List<Product> _products = await _databaseHelper.getProductsList();
      _productsList = _products;
      _state = ProductsState.LOADED;
    }

    update();
  }

  Future<void> addToCart({required Product product, int quantity = 1}) async {
    try {
      Product? existingProduct = _cartList.firstWhere(
        (cartItem) => cartItem.prodId == product.prodId,
      );

      if (existingProduct != null) {
        existingProduct.quantity = existingProduct.quantity! + quantity;
      }

      update();
    } catch (e) {
      Product newProduct = Product(
        prodId: product.prodId,
        prodImage: product.prodImage,
        prodName: product.prodName,
        prodPrice: product.prodPrice,
        prodSellPrice: product.prodPrice,
        quantity: quantity,
      );

      _cartList.insert(0, newProduct);
      update();
    }
  }

  Future<void> removeProduct(Product product) async {
    _cartList.removeWhere((cartItem) => cartItem.prodId == product.prodId);
    update();
  }
}

enum ProductsState {
  LOADING,
  LOADED,
  NO_PRODUCTS,
  ERROR,
}
