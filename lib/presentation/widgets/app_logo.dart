import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/core.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0),
      child: SvgPicture.asset(
        Assets.LOGO,
      ),
    );
  }
}
