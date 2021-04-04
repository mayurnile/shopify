import 'package:flutter/material.dart';

class ShopifyTheme {
  //colors
  static const Color PRIMARY_COLOR = Color(0xFF45BFE5);
  static const Color SECONDARY_COLOR = Color(0xFFFFFFFF);
  static const Color FONT_DARK_COLOR = Color(0xFF333333);
  static const Color FONT_LIGHT_COLOR = Color(0XFF808080);
  static const Color CARD_COLOR = Color(0xFFF7F7F7);
  static const Color UNSELECTED_COLOR = Color(0xFFDCDCDC);
  static const Color BACKGROUND_COLOR = Color(0xFFEAEAEA);
  static const Color ERROR_COLOR = Color(0xFFDA291C);

  static ThemeData shopifyThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: PRIMARY_COLOR,
    accentColor: PRIMARY_COLOR,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.w800,
        color: FONT_DARK_COLOR,
      ),
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: FONT_DARK_COLOR,
      ),
      headline3: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: FONT_LIGHT_COLOR,
      ),
      headline4: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: FONT_DARK_COLOR,
      ),
      headline5: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: FONT_LIGHT_COLOR,
      ),
      headline6: TextStyle(
        fontSize: 9.0,
        fontWeight: FontWeight.w300,
        color: FONT_LIGHT_COLOR,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: PRIMARY_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  );
}
