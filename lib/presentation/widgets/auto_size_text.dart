import 'package:flutter/material.dart';

class AutoSizeText extends StatelessWidget {
  final String text;
  final double size;
  final TextStyle style;
  final BoxFit fit;
  final Alignment alignment;

  AutoSizeText({
    Key? key,
    required this.text,
    required this.size,
    this.style = const TextStyle(),
    this.fit = BoxFit.scaleDown,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: FittedBox(
        fit: fit,
        alignment: alignment,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}
