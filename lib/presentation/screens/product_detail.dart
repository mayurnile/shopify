import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/core.dart';
import '../../di/locator.dart';
import '../../providers/providers.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  String _prodImage = '';
  String _prodName = '';
  double _prodPrice = 0.0;

  late Size screenSize;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();

    _prodImage =
        widget.product.prodImage != null ? widget.product.prodImage! : '';
    _prodName =
        widget.product.prodName != null ? widget.product.prodName! : 'Name';
    _prodPrice =
        widget.product.prodPrice != null ? widget.product.prodPrice! : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //product Image
          Center(
            child: Image.network(
              _prodImage,
              height: screenSize.height * 0.3,
              width: screenSize.width,
              fit: BoxFit.contain,
            ),
          ),
          //page indicator
          _buildPageIndicator(),
          //product title
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 22.0,
            ),
            child: SizedBox(
              width: screenSize.width,
              child: Text(
                _prodName,
                style: textTheme.headline2,
              ),
            ),
          ),
          //description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: SizedBox(
              width: screenSize.width,
              child: Text(
                "     Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                style: textTheme.headline5,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          //quantity selector
          _buildQuantitySelector(),
          //spacing
          Spacer(),
          //bottom bar
          _buildBottomBar(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: SizedBox(
        width: 42.0,
        child: TextButton(
          onPressed: () => locator.get<NavigationService>().navigateBack(),
          child: SvgPicture.asset(
            Assets.BACK,
            width: 22.0,
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: 56.0,
          child: TextButton(
            onPressed: () {},
            child: SvgPicture.asset(
              Assets.MENU,
              height: 32.0,
            ),
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 8.0,
          width: 16.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            color: ShopifyTheme.UNSELECTED_COLOR,
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          height: 8.0,
          width: 24.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            color: ShopifyTheme.PRIMARY_COLOR,
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          height: 8.0,
          width: 16.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            color: ShopifyTheme.UNSELECTED_COLOR,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 22.0, right: 22.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //title
          Text(
            'Quantity',
            style: textTheme.headline4,
          ),
          //quantity selector
          Container(
            width: screenSize.width * 0.4,
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              color: ShopifyTheme.BACKGROUND_COLOR,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //decrement
                IconButton(
                  onPressed: _decrementQuantity,
                  icon: Icon(
                    Icons.remove,
                    color: ShopifyTheme.FONT_DARK_COLOR,
                  ),
                ),
                //quantity count
                Text(
                  _quantity.toString(),
                  style: textTheme.headline2,
                ),
                //decrement
                IconButton(
                  onPressed: _incrementQuantity,
                  icon: Icon(
                    Icons.add,
                    color: ShopifyTheme.FONT_DARK_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //share button
          SvgPicture.asset(
            Assets.SHARE,
            color: ShopifyTheme.FONT_DARK_COLOR,
            width: 32.0,
          ),
          //like button
          SvgPicture.asset(
            Assets.LIKE,
            color: ShopifyTheme.FONT_DARK_COLOR,
            width: 32.0,
          ),
          //total price
          SizedBox(
            width: screenSize.width * 0.3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  text: 'Total\n',
                  style: textTheme.headline3,
                  children: [
                    TextSpan(
                      text: '₹ ${_prodPrice * _quantity}',
                      style: textTheme.headline2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          //add to cart
          InkWell(
            onTap: _addToCart,
            child: Container(
              height: screenSize.width * 0.17,
              width: screenSize.width * 0.17,
              decoration: BoxDecoration(
                color: ShopifyTheme.PRIMARY_COLOR,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsets.all(18.0),
              child: SvgPicture.asset(
                Assets.CART,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _incrementQuantity() {
    if (_quantity + 1 > 5) {
      Fluttertoast.showToast(msg: 'Max Quantity Reached !');
    } else {
      _quantity++;
    }
    setState(() {});
  }

  void _decrementQuantity() {
    if (_quantity - 1 == 0) {
      Fluttertoast.showToast(msg: 'Min Quantity Reached !');
    } else {
      _quantity--;
    }
    setState(() {});
  }

  void _addToCart() {
    locator.get<ProductsProvider>().addToCart(
          product: widget.product,
          quantity: _quantity,
        );

    Fluttertoast.showToast(msg: 'Item added to cart !');
    locator.get<NavigationService>().navigateBack();
  }
}
