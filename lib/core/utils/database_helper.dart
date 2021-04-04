import 'dart:io';
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/core.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database; 

  String productsTable = 'products_table';
  String colProdId = 'prodId';
  String colProdName = 'prodName';
  String colProdImage = 'prodImage';
  String colProdPrice = 'prodPrice';
  String colProdSellPrice = 'prodSell';

  DatabaseHelper._createInstance(); 

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); 
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'products.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $productsTable($colProdId INTEGER PRIMARY KEY, $colProdName TEXT, '
      '$colProdImage TEXT, $colProdPrice FLOAT, $colProdSellPrice FLOAT)',
    );
  }

  /// Fetch Operation: Get all Products objects from database
  Future<List<Map<String, dynamic>>> getProductsMapList() async {
    Database db = await this.database;

    var result = await db.query(productsTable);
    return result;
  }

  /// Insert Operation: Insert a Product object to database
  Future<int> insertProduct(Product product) async {
    Database db = await this.database;
    var result = await db.insert(productsTable, Product.toMap(product));
    return result;
  }

  /// Delete Operation: Delete all the products from database
  Future<void> deleteAllProducts() async {
    Database db = await this.database;
    await db.rawQuery('DELETE FROM $productsTable');
  }

  /// Get the 'Map List' [ List<Map> ] and convert it to 'Product List' [ List<Note> ]
  Future<List<Product>> getProductsList() async {
    var noteMapList = await getProductsMapList();
    int count = noteMapList.length;

    List<Product> noteList = List<Product>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Product.fromMap(noteMapList[i]));
    }

    return noteList;
  }
}
