import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class LikedItemsScreen extends StatelessWidget {
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
            text: 'Your\nLiked Items',
            style: textTheme.headline1!.copyWith(height: 1.2),
          ),
          //spacing
          SizedBox(height: 12.0),
          //subtitle
          AutoSizeText(
            size: screenSize.width - 44.0,
            text: 'You have no items added to liked list',
            style: textTheme.headline3!,
          ),
          //spacing
          SizedBox(height: 22.0),
        ],
      ),
    );
  }
}
