import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Text(
      'Shopify',
      style: textTheme.headline2,
    );
  }
}
