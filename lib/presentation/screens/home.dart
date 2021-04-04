import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
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
            text: 'Electronics\nCollection',
            style: textTheme.headline1.copyWith(height: 1.2),
          ),
          //spacing
          SizedBox(height: 12.0),
          //subtitle
          AutoSizeText(
            size: screenSize.width - 44.0,
            text:
                'We provide a wide range of electronics of all\nbrand and types',
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
                itemCount: _productsProvider.products.length,
                itemBuilder: (BuildContext ctx, int index) => ProductCard(
                  key: ValueKey(_productsProvider.products[index].prodId),
                  product: _productsProvider.products[index],
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
