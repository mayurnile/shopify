import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './screens.dart';
import '../../core/core.dart';
import '../../di/locator.dart';
import '../widgets/widgets.dart';
import '../../providers/providers.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    LikedItemsScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  late Size screenSize;
  late TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () =>
            locator.get<NavigationService>().removeAllAndPush(LANDING_ROUTE),
        child: Stack(
          children: [
            //main body
            _screens[_currentIndex],
            //navigation bar
            Positioned(
              bottom: 0,
              child: _buildNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: AppLogo(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: AppTitle(),
      actions: [
        //search button
        SizedBox(
          width: 42.0,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: SvgPicture.asset(
              Assets.SEARCH,
              width: 22.0,
            ),
          ),
        ),
        //filter button
        SizedBox(
          width: 42.0,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: SvgPicture.asset(
              Assets.FILTER,
              width: 22.0,
            ),
          ),
        ),
        //spacing
        SizedBox(
          width: 12.0,
        ),
      ],
    );
  }

  Widget _buildNavigationBar() {
    return GetBuilder<ProductsProvider>(
        builder: (ProductsProvider _productProvider) {
      int _cartItemCount = _productProvider.cartProducts.length;
      return Container(
        width: screenSize.width,
        height: screenSize.height * 0.08,
        decoration: BoxDecoration(
          color: ShopifyTheme.PRIMARY_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navBarItem(Assets.HOME, 0),
            _navBarItem(Assets.LIKE, 1),
            Badge(
              badgeContent: Text(
                '$_cartItemCount',
                style: textTheme.headline4,
              ),
              badgeColor: Colors.white,
              child: _navBarItem(Assets.CART, 2),
            ),
            _navBarItem(Assets.USER, 3),
          ],
        ),
      );
    });
  }

  Widget _navBarItem(String icon, int myIndex) {
    bool isSelected = myIndex == _currentIndex;

    return InkWell(
      onTap: () => setState(() => _currentIndex = myIndex),
      child: SvgPicture.asset(
        icon,
        width: 32.0,
        color: isSelected ? Colors.white : ShopifyTheme.UNSELECTED_COLOR,
      ),
    );
  }
}
