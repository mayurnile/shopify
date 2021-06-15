import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

import '../../core/core.dart';
import '../../di/locator.dart';
import '../../providers/providers.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool showOptions = false;

  //animation
  final Duration _animationDuration = Duration(milliseconds: 300);
  final Curve _animationCurve = Curves.easeInOutCubic;

  String _prodImage = '';
  String _prodName = '';

  @override
  void initState() {
    super.initState();
    _prodImage =
        widget.product.prodImage != null ? widget.product.prodImage! : '';
    _prodName =
        widget.product.prodName != null ? widget.product.prodName! : 'Name';
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SwipeGestureRecognizer(
      onSwipeLeft: () => setState(() => showOptions = true),
      onSwipeRight: () => setState(() => showOptions = false),
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height * 0.2,
        child: Stack(
          children: [
            //options card
            AnimatedPositioned(
              right: showOptions ? 22.0 : screenSize.width * 0.4,
              top: 0,
              bottom: 0,
              duration: _animationDuration,
              curve: _animationCurve,
              child: AnimatedContainer(
                duration: _animationDuration,
                curve: _animationCurve,
                width: screenSize.width * 0.3,
                decoration: BoxDecoration(
                  color: showOptions
                      ? ShopifyTheme.PRIMARY_COLOR
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(28.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                  left: 22.0,
                  top: 22.0,
                  bottom: 22.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //cart button
                    InkWell(
                      onTap: () {
                        locator
                            .get<ProductsProvider>()
                            .addToCart(product: widget.product);

                        Fluttertoast.showToast(msg: 'Item added to cart !');
                        setState(() => showOptions = false);
                      },
                      child: SvgPicture.asset(
                        Assets.CART,
                        color: Colors.white,
                        width: 32.0,
                      ),
                    ),
                    //divider
                    Divider(
                      color: ShopifyTheme.UNSELECTED_COLOR,
                      indent: 28.0,
                      endIndent: 12.0,
                      thickness: 1.5,
                    ),
                    //like button
                    SvgPicture.asset(
                      Assets.LIKE,
                      color: Colors.white,
                      width: 32.0,
                    ),
                  ],
                ),
              ),
            ),
            //main card
            AnimatedPositioned(
              duration: _animationDuration,
              curve: _animationCurve,
              left: showOptions ? -(screenSize.width * 0.25) : 0.0,
              child: InkWell(
                onTap: () => locator.get<NavigationService>().navigateToNamed(
                  PRODUCT_DETAILS_ROUTE,
                  arguments: {'product': widget.product},
                ),
                child: AnimatedContainer(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  decoration: BoxDecoration(
                    color: showOptions ? ShopifyTheme.CARD_COLOR : Colors.white,
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //left part
                      Image.network(
                        _prodImage,
                        height: screenSize.height * 0.2,
                        width: screenSize.width * 0.44,
                      ),
                      //right part
                      SizedBox(
                        width: screenSize.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //product name
                            Text(
                              _prodName,
                              style: textTheme.headline4,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            //spacing
                            SizedBox(height: 16.0),
                            //original price
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '₹ ${widget.product.prodPrice}',
                                style: textTheme.headline5!.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                            //actual price
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '₹ ${widget.product.prodSellPrice}',
                                style: textTheme.headline4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
