import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

import '../../core/core.dart';
import '../../di/locator.dart';
import '../../providers/providers.dart';

class CartProductCard extends StatefulWidget {
  final Product product;

  CartProductCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _CartProductCardState createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  bool showOptions = false;

  //animation
  final Duration _animationDuration = Duration(milliseconds: 300);
  final Curve _animationCurve = Curves.easeInOutCubic;

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
                    //delete button
                    InkWell(
                      onTap: () {
                        locator
                            .get<ProductsProvider>()
                            .removeProduct(widget.product);

                        Fluttertoast.showToast(msg: 'Item removed from cart !');
                        setState(() => showOptions = false);
                      },
                      child: SvgPicture.asset(
                        Assets.DELETE,
                        color: Colors.white,
                        width: 32.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //main body
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
                        widget.product.prodImage,
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
                              widget.product.prodName,
                              style: textTheme.headline4,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            //spacing
                            SizedBox(height: 16.0),
                            //quantity
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Quantity: ${widget.product.quantity}',
                                style: textTheme.headline5,
                              ),
                            ),
                            //actual price
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '₹ ${widget.product.prodSellPrice * widget.product.quantity}',
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
