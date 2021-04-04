import 'package:flutter/material.dart';
import 'package:shopify/core/core.dart';

import './route_names.dart';
import '../../presentation/screens/screens.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _getPageRoute(LandingScreen(), settings);
    case LANDING_ROUTE:
      return _getPageRoute(LandingScreen(), settings);
    case PRODUCT_DETAILS_ROUTE:
      final args = settings.arguments as Map<String, dynamic>;

      return _getPageRoute(
        ProductDetailsScreen(
          product: args['product'],
        ),
        settings,
      );
    default:
      return _getPageRoute(LandingScreen(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              child,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(opacity: animation, child: child),
        );
}
