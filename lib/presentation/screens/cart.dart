import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../../providers/providers.dart';

class CartScreen extends StatelessWidget {
  final ProductsProvider _productsProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //welcome section
            _buildWelcomeSection(screenSize, textTheme),
            //products list section
            _buildProductsListSection(screenSize, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(Size screenSize, TextTheme textTheme) {
    int _itemCount = _productsProvider.cartProducts.length;

    String explanationText = _itemCount == 0
        ? 'You have no items added to cart'
        : 'You have $_itemCount item(s) in your cart';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //spacing
          SizedBox(height: 16.0),
          //title
          AutoSizeText(
            size: screenSize.width - 44.0,
            text: 'Your\nCart',
            style: textTheme.headline1.copyWith(height: 1.2),
          ),
          //spacing
          SizedBox(height: 12.0),
          //subtitle
          AutoSizeText(
            size: screenSize.width - 44.0,
            text: explanationText,
            style: textTheme.headline3,
          ),
          //spacing
          SizedBox(height: 22.0),
        ],
      ),
    );
  }

  Widget _buildProductsListSection(Size screenSize, TextTheme textTheme) {
    return GetBuilder<ProductsProvider>(
      builder: (ProductsProvider _productsProvider) {
        switch (_productsProvider.productsState) {
          case ProductsState.LOADED:
            return Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _productsProvider.cartProducts.length,
                itemBuilder: (BuildContext ctx, int index) => CartProductCard(
                  key: ValueKey(_productsProvider.cartProducts[index].prodId),
                  product: _productsProvider.cartProducts[index],
                ),
              ),
            );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
